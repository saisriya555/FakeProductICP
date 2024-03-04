export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'QrCode' : IDL.Func([IDL.Nat], [IDL.Text], []),
    'addProductToSeller' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Nat, IDL.Text],
        [IDL.Text],
        [],
      ),
    'buyProduct' : IDL.Func(
        [IDL.Text, IDL.Text, IDL.Nat, IDL.Text],
        [IDL.Text],
        [],
      ),
    'removeProduct' : IDL.Func([IDL.Text], [IDL.Text], []),
  });
};
export const init = ({ IDL }) => { return []; };
