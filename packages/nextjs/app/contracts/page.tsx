import { DebugContracts } from "./_components/DebugContracts";
import type { NextPage } from "next";
import { getMetadata } from "~~/utils/scaffold-eth/getMetadata";

export const metadata = getMetadata({
  title: "Debug Contracts",
  // @dev: changed description
  description: "Debug your deployed contracts in an easy way",
});

const Debug: NextPage = () => {
  return (
    <>
      <DebugContracts />
      {/* @dev: deleted */}
    </>
  );
};

export default Debug;
