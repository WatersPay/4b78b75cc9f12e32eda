use bip39::{Language, Mnemonic, MnemonicType};
use data_encoding::HEXLOWER;
use sp_core;
use sp_core::crypto::Ss58Codec;
use sp_core::Pair;

#[derive(Debug)]
pub struct PolkadotAddress {
    pub mnemonic_phrase: String,
    pub mini_secret_key: String,
    pub public_key: String,
    pub address: String,
}

pub fn generate_wallet(
    ss58: u16,
    password: Option<String>,
    length: MnemonicType,
    lang: Language,
) -> PolkadotAddress {
    let mnemonic = Mnemonic::new(length, lang);
    let phrase = mnemonic.phrase();

    let (pair, seed) = match password {
        Some(p) => sp_core::sr25519::Pair::from_phrase(phrase, Some(&p))
            .expect("All phrases generated by Mnemonic are valid; qed"),
        None => sp_core::sr25519::Pair::from_phrase(phrase, None)
            .expect("All phrases generated by Mnemonic are valid; qed"),
    };

    let address = sp_core::crypto::AccountId32::from(pair.public())
        .to_ss58check_with_version(sp_core::crypto::Ss58AddressFormat::custom(ss58.into()));

    let data = PolkadotAddress {
        mnemonic_phrase: phrase.to_owned(),
        mini_secret_key: HEXLOWER.encode(&seed),
        public_key: HEXLOWER.encode(&<[u8; 32]>::from(pair.public())),
        address,
    };

    data
}
