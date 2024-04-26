import { useState } from "react";
import { CheckCircleIcon, DocumentDuplicateIcon } from "@heroicons/react/24/outline";

// @note: This component is used to copy a fixed string to the clipboard.
// @dev: This component has bug now, it will not work properly, need to fix it.
export const CopyString = (fixedStringToCopy: string) => {
  const [stringCopied, setStringCopied] = useState(false);

  const handleCopy = () => {
    navigator.clipboard
      .writeText(fixedStringToCopy)
      .then(() => {
        setStringCopied(true);
        setTimeout(() => {
          setStringCopied(false);
        }, 800);
      })
      .catch(err => {
        console.error("Failed to copy: ", err);
      });
  };

  return (
    <div>
      {stringCopied ? (
        <div className="btn-sm !rounded-xl flex gap-3 py-3">
          <CheckCircleIcon className="text-xl font-normal h-6 w-4 cursor-pointer ml-2 sm:ml-0" aria-hidden="true" />
          <span className="whitespace-nowrap">String Copied</span>
        </div>
      ) : (
        <div onClick={handleCopy} className="btn-sm !rounded-xl flex gap-3 py-3 cursor-pointer">
          <DocumentDuplicateIcon
            className="text-xl font-normal h-6 w-4 cursor-pointer ml-2 sm:ml-0"
            aria-hidden="true"
          />
          <span className="whitespace-nowrap">Copy String</span>
        </div>
      )}
    </div>
  );
};
