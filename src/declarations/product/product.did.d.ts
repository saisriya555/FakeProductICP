import type { Principal } from '@dfinity/principal';
export interface _SERVICE {
  'QrCode' : (arg_0: bigint) => Promise<string>,
  'addProductToSeller' : (
      arg_0: string,
      arg_1: string,
      arg_2: bigint,
      arg_3: string,
    ) => Promise<string>,
  'buyProduct' : (
      arg_0: string,
      arg_1: string,
      arg_2: bigint,
      arg_3: string,
    ) => Promise<string>,
  'removeProduct' : (arg_0: string) => Promise<string>,
}
