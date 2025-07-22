DELETEDDATAOBJECT_MAP = {
    0: "TypeName",
    1: "Id",
}

ACCOUNTTOKEN_MAP = {
    0: "Type",
    1: "Value",
}

AUTHENTICATEDMMCLIENTPAYLOAD_MAP = {
    0: "ViewerId",
    1: "OnetimeToken",
}

SIGNINPAYLOAD_MAP = {
    0: "Provider",
    1: "Parameter1",
    2: "Parameter2",
}

STRINGRESULT_MAP = {
    0: "String",
}

BOOLEANRESULT_MAP = {
    0: "IsSuccess",
}

GACHARESULT_MAP = {
    0: "CandidateCharacterMasterIds",
    1: "KeepingSlots",
    2: "ObtainedUserRollCountRewardId",
    3: "ObtainedSerialCode",
}

KEEPINGSLOT_MAP = {
    0: "SlotPosition",
    1: "CharacterMasterId",
    2: "IsAcquired",
}

GACHAPROBABILITYRESULT_MAP = {
    0: "GachaMasterId",
    1: "RollCount",
    2: "CharacterProbabilityResults",
}

GACHACHARACTERPROBABILITYRESULT_MAP = {
    0: "CharacterMasterId",
    1: "CharacterName",
    2: "Rarity",
    3: "MasterProbability",
    4: "ResultCount",
    5: "ResultProbability",
}

HOMERESULT_MAP = {
    0: "DailyRollLeft",
    1: "UserRollCount",
    2: "OverallRollCount",
    3: "IsEffectSkip",
    4: "CanRecoverRollCountWithTweet",
    5: "IsWaitingForDecistion",
    6: "KeepingSlots",
    7: "ReceivedSerialCodes",
    8: "LastPerformedRewardRollCount",
}

RECEIVEDSERIALCODE_MAP = {
    0: "Order",
    1: "SerialCode",
}

IZANAMIENVIRONMENTCONFIGURATION_MAP = {
    0: "BackendUrl",
    1: "AssetsUrl",
    2: "StaticContentUrl",
    3: "MaintenanceUrl",
    4: "IsDebugMode",
    5: "IsAdult",
    6: "IsOpenPreRegistration",
    7: "IsMaintenance",
    8: "MaintenanceUntil",
}

CHANGEKEEPCHARACTERSPAYLOAD_MAP = {
    0: "ChangeKeepCharacters",
}

CHANGEKEEPCHARACTER_MAP = {
    0: "SlotPosition",
    1: "CharacterMasterId",
}

MASTERRESULT_MAP = {
    0: "IsOpenPreRegistration",
    1: "Characters",
    2: "UserRollCountRewards",
    3: "OverallRollCountRewards",
    4: "MazeGuarders",
    5: "GachaCharacters",
    6: "IsMgMove",
}

CHARACTERMASTER_MAP = {
    0: "Id",
    1: "Name",
    2: "AnotherName",
    3: "Rarity",
    5: "CharacterType",
    6: "Introduction",
    7: "AssetId",
    8: "ModelAssetId",
    11: "Attribute",
    12: "PositionType",
    13: "RoleType",
    14: "MazeGurederMasterId",
    15: "SchoolType",
    16: "TeamType",
}

USERROLLCOUNTREWARDMASTER_MAP = {
    0: "Id",
    1: "Count",
}

OVERALLROLLCOUNTREWARDMASTER_MAP = {
    0: "Id",
    1: "Count",
}

MAZEGUARDERMASTER_MAP = {
    0: "Id",
    1: "Name",
    2: "Rubi",
    3: "Height",
    4: "Identification",
    5: "Affiliation",
}

GACHACHARACTERMASTER_MAP = {
    0: "Id",
    1: "GachaMasterId",
    2: "CharacterMasterId",
}

FAULT_MAP = {
    0: "ErrorCode",
    1: "Message",
    2: "StackTrace",
}

MASTERDATAPACKAGE_MAP = {
    0: "MasterData",
    1: "Version",
}

AUTHRESULT_MAP = {
    0: "Token",
}

GACHAMASTER_MAP = {
    0: "Id",
    1: "StartDate",
    2: "EndDate",
}

ADDITIONALFORMATERGENERATOR_MAP = {
    0: "DataObjectArray",
    1: "FaultArray",
    2: "DeletedDataObjectArray",
}

RUNTIMECONFIGURATION_MAP = {
    0: "IsRated",
}

MASTER_RESULT_STRUCTURE = {
    0: ("IsOpenPreRegistration", None),
    1: ("Characters", CHARACTERMASTER_MAP),
    2: ("UserRollCountRewards", USERROLLCOUNTREWARDMASTER_MAP),
    3: ("OverallRollCountRewards", OVERALLROLLCOUNTREWARDMASTER_MAP),
    4: ("MazeGuarders", MAZEGUARDERMASTER_MAP),
    5: ("GachaCharacters", GACHACHARACTERMASTER_MAP),
    6: ("IsMgMove", None),
}
