"use client";

import Link from "next/link";
import type { NextPage } from "next";
import { useAccount } from "wagmi";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";
import { Address, Balance } from "~~/components/scaffold-eth";

// import { CopyString } from "./CopyString";

const Home: NextPage = () => {
  const { address: connectedAddress } = useAccount();

  return (
    <>
      <div className="flex items-center flex-col flex-grow pt-10">
        <div className="px-5">
          <h1 className="text-center">
            <span className="block text-2xl mb-2">欢迎使用金融衍生品期权协议</span>
            <span className="block text-5xl font-bold">Deriva-Option</span>
          </h1>
          <div className="flex justify-center items-center space-x-2">
            <p className="my-2 font-medium">已连接的账户地址:</p>
            <Address address={connectedAddress} />
          </div>
          <p className="text-center text-lg">
            可使用的本地账户私钥1：
            <code className="italic bg-base-300 text-base font-bold max-w-full break-words break-all inline-block">
              0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
            </code>
          </p>
          <p className="text-center text-lg">
            私钥2：
            <code className="italic bg-base-300 text-base font-bold max-w-full break-words break-all inline-block">
              0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d
            </code>
          </p>
        </div>
        <div className="block text-2xl mx-2">本项目实现了ERC20之间的金融衍生品期权协议</div>
        {/* TODO: copy private key to clipboard */}
        {/* <div>
          <p className="text-center text-lg mx-4">
            <Address address="0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266" />
            <Balance address="0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266" />
          </p>
          <p className="text-center text-lg mx-4">
            <Address address="0x70997970c51812dc3a010c7d01b50e0d17dc79c8" />
            <Balance address="0x70997970c51812dc3a010c7d01b50e0d17dc79c8" />
          </p>
          <p className="text-center text-lg mx-4">
            <Address address="0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc" />
            <Balance address="0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc" />
          </p>
          <p className="text-center text-lg mx-4">
            <Address address="0x90f79bf6eb2c4f870365e785982e1f101e93b906" />
            <Balance address="0x90f79bf6eb2c4f870365e785982e1f101e93b906" />
          </p>
          <p className="text-center text-lg mx-4">
            <Address address="0x15d34aaf54267db7d7c367839aaf71a00a2c6a65" />
            <Balance address="0x15d34aaf54267db7d7c367839aaf71a00a2c6a65" />
          </p>
        </div> */}
        <div className="flex-grow bg-base-300 w-full mt-16 px-8 py-12">
          <div className="flex justify-center items-center gap-12 flex-col sm:flex-row">
            <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
              <BugAntIcon className="h-8 w-8 fill-secondary" />
              <p>
                使用&nbsp;
                <Link href="/debug" passHref className="link">
                  调试合约
                </Link>
                &nbsp;进行合约调试。
              </p>
            </div>
            <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
              <MagnifyingGlassIcon className="h-8 w-8 fill-secondary" />
              <p>
                使用{" "}
                <Link href="/blockexplorer" passHref className="link">
                  区块浏览器
                </Link>{" "}
                查询本地交易
              </p>
            </div>
          </div>
        </div>
      </div>
    </>
  );
};

export default Home;
