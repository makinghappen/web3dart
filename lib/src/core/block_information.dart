import 'package:webthree/src/crypto/formatting.dart';
import 'package:webthree/webthree.dart';

class BlockInformation {
  final EthereumAddress? from; // Author
  final String? boundary;
  final String? difficulty;
  final String? extraData;
  final String? gasLimit;
  final String? gasUsed;
  final String? hash;
  final String? logsBloom;
  final EthereumAddress? miner;
  final String? mixHash;
  final String? nonce;
  final EtherAmount? baseFeePerGas;
  final int? number;
  final String? parentHash;
  final String? receiptsRoot;
  final String? seedHash;
  final String? sha3Uncles;
  final String? size;
  final String? stateRoot;
  final DateTime? timestamp;
  final String? totalDifficulty;
  final List<TransactionInformation>? transactions;
  final String? transactionsRoot;
  final List<dynamic>? uncles;

  BlockInformation({
    this.from,
    this.boundary,
    this.difficulty,
    this.extraData,
    this.gasLimit,
    this.gasUsed,
    this.hash,
    this.logsBloom,
    this.miner,
    this.mixHash,
    this.nonce,
    this.baseFeePerGas,
    this.number,
    this.parentHash,
    this.receiptsRoot,
    this.seedHash,
    this.sha3Uncles,
    this.size,
    this.stateRoot,
    this.timestamp,
    this.totalDifficulty,
    this.transactions,
    this.transactionsRoot,
    this.uncles,
  });

  factory BlockInformation.fromJson(Map<String, dynamic> json) {
    final List<Map<String, dynamic>>? _list =
        List.castFrom(json['transactions'] as List<dynamic>);
    List<TransactionInformation>? _transactions;
    if (_list != null) {
      _transactions = _list
          .map((Map<String, dynamic> e) => TransactionInformation.fromMap(e))
          .toList();
    } else {
      _transactions = null;
    }

    final EthereumAddress? _from = json.containsKey('author')
        ? EthereumAddress.fromHex(json['author'] as String)
        : null;
    final String? _boundary =
        json.containsKey('boundary') ? json['boundary'] as String : null;
    final String? _difficulty =
        json.containsKey('difficulty') ? json['difficulty'] as String : null;
    final String? _extraData =
        json.containsKey('extraData') ? json['extraData'] as String : null;
    final String? _gasLimit =
        json.containsKey('gasLimit') ? json['gasLimit'] as String : null;
    final String? _gasUsed =
        json.containsKey('gasUsed') ? json['gasUsed'] as String : null;
    final String? _hash =
        json.containsKey('hash') ? json['hash'] as String : null;
    final String? _logsBloom =
        json.containsKey('logsBloom') ? json['logsBloom'] as String : null;
    final EthereumAddress? _miner = json.containsKey('miner')
        ? EthereumAddress.fromHex(json['miner'] as String)
        : null;
    final String? _mixHash =
        json.containsKey('mixHash') ? json['mixHash'] as String : null;
    final String? _nonce =
        json.containsKey('nonce') ? json['nonce'] as String : null;
    final EtherAmount? _baseFeePerGas = json.containsKey('baseFeePerGas')
        ? EtherAmount.fromUnitAndValue(
            EtherUnit.wei, hexToInt(json['baseFeePerGas'] as String))
        : null;
    final int? _number =
        json.containsKey('number') ? json['number'] as int : null;
    final String? _parentHash =
        json.containsKey('parentHash') ? json['parentHash'] as String : null;
    final String? _receiptsRoot = json.containsKey('receiptsRoot')
        ? json['receiptsRoot'] as String
        : null;
    final String? _seedHash =
        json.containsKey('seedHash') ? json['seedHash'] as String : null;
    final String? _sha3Uncles =
        json.containsKey('sha3Uncles') ? json['sha3Uncles'] as String : null;
    final String? _size =
        json.containsKey('size') ? json['size'] as String : null;
    final String? _stateRoot =
        json.containsKey('stateRoot') ? json['size'] as String : null;
    final DateTime? _timestamp =
        json.containsKey('timestamp') ? json['timestamp'] as DateTime : null;
    final String? _totalDifficulty = json.containsKey('totalDifficulty')
        ? json['totalDifficulty'] as String
        : null;
    final String? _transactionsRoot = json.containsKey('transactionsRoot')
        ? json['transactionsRoot'] as String
        : null;
    final List<dynamic>? _uncles =
        json.containsKey('uncles') ? json['uncles'] as List<dynamic> : null;

    return BlockInformation(
      from: _from,
      boundary: _boundary,
      difficulty: _difficulty,
      extraData: _extraData,
      gasLimit: _gasLimit,
      gasUsed: _gasUsed,
      hash: _hash,
      logsBloom: _logsBloom,
      miner: _miner,
      mixHash: _mixHash,
      nonce: _nonce,
      baseFeePerGas: _baseFeePerGas,
      number: _number,
      parentHash: _parentHash,
      receiptsRoot: _receiptsRoot,
      seedHash: _seedHash,
      sha3Uncles: _sha3Uncles,
      size: _size,
      stateRoot: _stateRoot,
      timestamp: _timestamp,
      totalDifficulty: _totalDifficulty,
      transactions: _transactions,
      transactionsRoot: _transactionsRoot,
      uncles: _uncles,
    );
  }

  bool get isSupportEIP1559 => baseFeePerGas != null;
}

class BlockInformationWithTransactions extends BlockInformation {
  final List<TransactionInformation> transactions;

  BlockInformationWithTransactions({
    required int? number,
    required EtherAmount? baseFeePerGas,
    required DateTime timestamp,
    required this.transactions,
  }) : super(
          number: number,
          baseFeePerGas: baseFeePerGas,
          timestamp: timestamp,
        );

  factory BlockInformationWithTransactions.fromMap(Map<String, dynamic> map) {
    return BlockInformationWithTransactions(
      number: _parseNumber(map),
      baseFeePerGas: _parseBaseFeePerGas(map),
      timestamp: _parseTimestamp(map),
      transactions: _parseTransactions(map),
    );
  }

  static List<TransactionInformation> _parseTransactions(
      Map<String, dynamic> map) {
    return (map['transactions'] as List)
        .cast<Map<String, dynamic>>()
        .map((map) => TransactionInformation.fromMap(map))
        .toList(growable: false);
  }
}

int? _parseNumber(Map<String, dynamic> map) {
  if (!map.containsKey('number')) return null;
  return hexToDartInt(map['number'] as String);
}

EtherAmount? _parseBaseFeePerGas(Map<String, dynamic> map) {
  if (!map.containsKey('baseFeePerGas')) return null;

  return EtherAmount.fromUnitAndValue(
    EtherUnit.wei,
    hexToInt(map['baseFeePerGas'] as String),
  );
}

DateTime _parseTimestamp(Map<String, dynamic> map) {
  return DateTime.fromMillisecondsSinceEpoch(
    hexToDartInt(map['timestamp'] as String) * 1000,
    isUtc: true,
  );
}
