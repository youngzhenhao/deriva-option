import { FormatChineseDate } from "./FormatChineseDate";
import { TransactionHash } from "./TransactionHash";
import { formatEther } from "viem";
import { Address } from "~~/components/scaffold-eth";
import { useTargetNetwork } from "~~/hooks/scaffold-eth/useTargetNetwork";
import { TransactionWithFunction } from "~~/utils/scaffold-eth";
import { TransactionsTableProps } from "~~/utils/scaffold-eth/";

export const TransactionsTable = ({ blocks, transactionReceipts }: TransactionsTableProps) => {
  const { targetNetwork } = useTargetNetwork();

  return (
    <div className="flex justify-center px-4 md:px-0">
      <div className="overflow-x-auto w-full shadow-2xl rounded-xl">
        <table className="table text-xl bg-base-100 table-zebra w-full md:table-md table-sm">
          <thead>
            <tr className="rounded-xl text-sm text-base-content">
              <th className="text-center bg-primary">交易哈希</th>
              <th className="text-center bg-primary">调用函数</th>
              <th className="text-center bg-primary">区块编号</th>
              <th className="text-center bg-primary">出块时刻</th>
              <th className="bg-primary">&emsp;&emsp;&ensp;发起地址</th>
              <th className="bg-primary">&emsp;&emsp;&ensp;接收地址</th>
              <th className="text-center bg-primary text-end">交易价值 ({targetNetwork.nativeCurrency.symbol})</th>
            </tr>
          </thead>
          <tbody>
            {blocks.map(block =>
              (block.transactions as TransactionWithFunction[]).map(tx => {
                const receipt = transactionReceipts[tx.hash];
                // @dev: edited
                const timeMined = FormatChineseDate(new Date(Number(block.timestamp) * 1000));
                // const timeMined = new Date(Number(block.timestamp) * 1000).toLocaleString('zh-CN', { timeZone: 'Asia/Shanghai' });
                const functionCalled = tx.input.substring(0, 10);

                return (
                  <tr key={tx.hash} className="hover text-sm">
                    <td className="w-1/12 md:py-4">
                      <TransactionHash hash={tx.hash} />
                    </td>
                    <td className="text-right w-2/12 md:py-4">
                      {tx.functionName === "0x" ? "" : <span className="mr-1">{tx.functionName}</span>}
                      {functionCalled !== "0x" && (
                        <span className="badge badge-primary font-bold text-xs">{functionCalled}</span>
                      )}
                    </td>
                    <td className="text-center w-1/12 md:py-4">{block.number?.toString()}</td>
                    <td className="text-center w-2/1 md:py-4">{timeMined}</td>
                    <td className="w-2/12 md:py-4">
                      <Address address={tx.from} size="sm" />
                    </td>
                    <td className="w-2/12 md:py-4">
                      {!receipt?.contractAddress ? (
                        tx.to && <Address address={tx.to} size="sm" />
                      ) : (
                        <div className="relative">
                          <Address address={receipt.contractAddress} size="sm" />
                          <small className="absolute top-4 left-4">&emsp;(合约创建)</small>
                        </div>
                      )}
                    </td>
                    <td className="text-right md:py-4">
                      {formatEther(tx.value)} {targetNetwork.nativeCurrency.symbol}
                    </td>
                  </tr>
                );
              }),
            )}
          </tbody>
        </table>
      </div>
    </div>
  );
};
