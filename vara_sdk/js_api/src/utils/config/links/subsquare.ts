export default {
  chains: {
    Acala: "acala",
    Altair: "altair",
    Basilisk: "basilisk",
    Bifrost: "bifrost",
    Centrifuge: "centrifuge",
    Crust: "crust",
    "Darwinia Crab": "crab",
    HydraDX: "hydradx",
    Interlay: "interlay",
    Karura: "karura",
    Khala: "khala",
    Kusama: "kusama",
    Litmus: "litmus",
    Phala: "phala",
    Polkadot: "polkadot",
    Rococo: "rococo",
    "Turing Network": "turing",
    Zeitgeist: "zeitgeist",
    kintsugi: "kintsugi",
  },
  create: (chain: string, path: string, data: any): string => `https://${chain}.subsquare.io/${path}/${data.toString()}`,
  isActive: true,
  paths: {
    bounty: "treasury/bounty",
    council: "council/motion",
    proposal: "democracy/proposal",
    referendum: "democracy/referendum",
    referenda: "referenda/referendum",
    tip: "treasury/tip",
    treasury: "treasury/proposal",
  },
  url: "https://subsquare.io/",
};