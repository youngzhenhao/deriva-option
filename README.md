# Deriva-Option

ERC20 之间的金融衍生品期权协议

## 说明

本项目依赖版本

- node v18.20.0
- npm v10.5.0
- yarn v3.2.3
- solidity v0.8.22
- forge v0.2.0
- anvil v0.2.0

## TODO

- 增加 ETH 和 ERC20 之间的期权交易
- 是否增加更多期权价格逻辑(交流...)
- 完成CopyString.tsx
- 更改主题颜色，tailwind theme generator
- 增加更多的功能
- 文档和指导记录

## 开始使用

0. 克隆本项目到本地

```bash
git clone https://github.com/youngzhenhao/deriva-option.git
```

1. 在项目文件夹安装依赖

```powershell
cd .\deriva-option
yarn
```

2. 在项目的 `.\packages\foundry\.env` 和`.\packages\nextjs\.env.local` 文件中配置环境变量

- `DEPLOYER_PRIVATE_KEY` 是部署者的私钥，用于部署测试合约，可在本地网络启动后从控制台输出复制一个有余额的可用私钥
- `ALCHEMY_API_KEY` 和 `ETHERSCAN_API_KEY` 是用于连接以太坊测试网络的 API 密钥，自行注册获取
- `NEXT_PUBLIC_ALCHEMY_API_KEY` 和 `ALCHEMY_API_KEY` 相同即可
- `NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID` 在 Wallet Connect 注册获取

```
# .env
DEPLOYER_PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
ALCHEMY_API_KEY=
ETHERSCAN_API_KEY=
# .env.local
NEXT_PUBLIC_ALCHEMY_API_KEY=
NEXT_PUBLIC_WALLET_CONNECT_PROJECT_ID=
```

- 在 `.\packages\foundry\foundry.toml` 配置本地网络
- 查看 `DEPLOYER_PRIVATE_KEY` 对应的账户地址在各网络余额：

```
yarn account
```

3. 在第一个终端中启动本地以太坊网络：

```powershell
yarn chain
```

- 使用 JSON-RPC 与本地网络交互
  https://ethereum.github.io/execution-apis/api-documentation/

4. 在第二个终端中启动前端项目：

```
yarn start
```

- 访问 `http://localhost:3000` 访问前端项目

5. 在第三个终端中编译并部署智能合约：

- 部署一个 Deriva-Option 合约绑定的 ERC20 稳定币 DAI 合约
- 部署另一个与 DAI 进行期权交易的 ERC20 稳定币 FT 合约
- 部署 Deriva-Option 合约

```
yarn deploy:DAI
yarn deploy:FT
yarn deploy:DeOp
```

6. 部署完成后，在前端页面使用 MetaMask 连接账户

7. 在调试合约界面进行期权交易

- 如合约调用一直处于等待状态，重新安装MetaMask(暂解决)

8. 在区块浏览器界面进行交易查询
