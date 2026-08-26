-- chunkname: @modules/logic/rouge2/outside/define/Rouge2_OutsideEnum.lua

module("modules.logic.rouge2.outside.define.Rouge2_OutsideEnum", package.seeall)

local Rouge2_OutsideEnum = _M

Rouge2_OutsideEnum.FinishEnum = {
	Finish = 1,
	Fail = 2
}
Rouge2_OutsideEnum.CollectionType = {
	Collection = 1,
	Material = 2,
	Formula = 3
}
Rouge2_OutsideEnum.CollectionDisplayType = {
	Formula = 2,
	Collection = 1
}
Rouge2_OutsideEnum.UnlockTitle = {
	[Rouge2_OutsideEnum.CollectionType.Collection] = "rouge2_result_relicsl_unlock_title",
	[Rouge2_OutsideEnum.CollectionType.Formula] = "rouge2_result_formula_unlock_title"
}
Rouge2_OutsideEnum.FormulaRareColor = {
	"#94B4E7",
	"#D99CEB",
	"#E88545"
}
Rouge2_OutsideEnum.MaterialNumColor = {
	Enough = "#60A667",
	NotEnough = "#CA6C6B"
}
Rouge2_OutsideEnum.EndDescColor = {
	Fail = "#762222",
	Success = "#1E254C"
}
Rouge2_OutsideEnum.SubMaterialDisplayType = {
	Wearable = 2,
	DisplayOnly = 1
}
Rouge2_OutsideEnum.CareerTalentDisplayType = {
	Wearable = 2,
	DisplayOnly = 1
}
Rouge2_OutsideEnum.AlchemyTempAlpha = {
	Select = 1,
	Temp = 0.7
}
Rouge2_OutsideEnum.AlchemyItemType = {
	SubMaterial = 2,
	Formula = 1
}
Rouge2_OutsideEnum.MaterialType = {
	Sub = 2,
	Main = 1
}
Rouge2_OutsideEnum.MaterialReturnNum = 1
Rouge2_OutsideEnum.MaterialRare = 1
Rouge2_OutsideEnum.AlchemyItemLineCount = 4
Rouge2_OutsideEnum.MainMaterialCount = 2
Rouge2_OutsideEnum.TalentOriginOrder = 1
Rouge2_OutsideEnum.AlchemySuccessViewState = {
	Detail = 2,
	Success = 1
}
Rouge2_OutsideEnum.CollectionListType = {
	Passion = 5,
	Reaction = 2,
	Buff = 200,
	AutoBuff = 300,
	Perception = 4,
	Collection = 100,
	Secret = 3,
	Power = 1
}
Rouge2_OutsideEnum.CollectionTagType = {
	Rouge2_OutsideEnum.CollectionListType.Collection,
	Rouge2_OutsideEnum.CollectionListType.Buff,
	Rouge2_OutsideEnum.CollectionListType.AutoBuff
}
Rouge2_OutsideEnum.CollectionTypeSort = {
	[Rouge2_OutsideEnum.CollectionListType.Power] = 1,
	[Rouge2_OutsideEnum.CollectionListType.Reaction] = 2,
	[Rouge2_OutsideEnum.CollectionListType.Secret] = 3,
	[Rouge2_OutsideEnum.CollectionListType.Perception] = 4,
	[Rouge2_OutsideEnum.CollectionListType.Passion] = 5,
	[Rouge2_OutsideEnum.CollectionListType.Collection] = 6,
	[Rouge2_OutsideEnum.CollectionListType.AutoBuff] = 7,
	[Rouge2_OutsideEnum.CollectionListType.Buff] = 8
}
Rouge2_OutsideEnum.CollectionListRowNum = 4
Rouge2_OutsideEnum.IllustrationNumOfPage = 6
Rouge2_OutsideEnum.MinCollectionExtraTagID = 100
Rouge2_OutsideEnum.CollectionHeight = {
	Big = 285,
	Small = 224
}
Rouge2_OutsideEnum.CollectionListViewDelayTime = 0.167
Rouge2_OutsideEnum.FirstLayerId = 111
Rouge2_OutsideEnum.CareerTalentGroupNodeCount = 3
Rouge2_OutsideEnum.CollectionInfoType = {
	Complex = 2,
	Simple = 1
}
Rouge2_OutsideEnum.DefaultCollectionInfoType = Rouge2_OutsideEnum.CollectionInfoType.Simple
Rouge2_OutsideEnum.BeginType = 1
Rouge2_OutsideEnum.MinMiddleType = 2
Rouge2_OutsideEnum.MaxMiddleType = 5
Rouge2_OutsideEnum.EndType = 6
Rouge2_OutsideEnum.SceneIndex = {
	MainScene = 2,
	CareerScene = 4,
	DifficultyScene = 3,
	EnterScene = 1,
	LevelScene = 5
}
Rouge2_OutsideEnum.SceneCount = 4
Rouge2_OutsideEnum.RoleSpineOffset = 7
Rouge2_OutsideEnum.SceneOpenDelay = {
	[Rouge2_OutsideEnum.SceneIndex.EnterScene] = 1.2,
	[Rouge2_OutsideEnum.SceneIndex.MainScene] = 1.7,
	[Rouge2_OutsideEnum.SceneIndex.DifficultyScene] = 0.8,
	[Rouge2_OutsideEnum.SceneIndex.CareerScene] = 0.8,
	[Rouge2_OutsideEnum.SceneIndex.LevelScene] = 0.7
}
Rouge2_OutsideEnum.DifficultyChangeTime = 1.333
Rouge2_OutsideEnum.CareerRefreshTime = 0.167
Rouge2_OutsideEnum.CareerSwitchFinishTime = 1.833
Rouge2_OutsideEnum.ForceCloseMaskTime = 5
Rouge2_OutsideEnum.SwitchViewOpenTime = 0.5
Rouge2_OutsideEnum.TarotDefaultFOV = 22
Rouge2_OutsideEnum.AlchemySwitchFinishTime = 0.5
Rouge2_OutsideEnum.AlchemySwitchRefreshTime = 0.167
Rouge2_OutsideEnum.AlchemySuccessFxTime = 2.167
Rouge2_OutsideEnum.TalentBigIndex = 2.167
Rouge2_OutsideEnum.TalentLightAnimTime = 1.2
Rouge2_OutsideEnum.TalentRefreshAnimTime = 0.7
Rouge2_OutsideEnum.TalentLineAnimTime = 0.7
Rouge2_OutsideEnum.TalentLinePos = {
	[2] = {
		1,
		0.82,
		0.52,
		0.21,
		0
	},
	[4] = {
		1,
		0.87,
		0.58,
		0.27,
		0.095
	},
	[6] = {
		1,
		0.9,
		0.62,
		0.3,
		0.145
	},
	[8] = {
		1,
		0.92,
		0.65,
		0.33,
		0.185
	}
}
Rouge2_OutsideEnum.CareerSwitchRefreshTime = 0.333
Rouge2_OutsideEnum.CareerLevelUpTime = 1
Rouge2_OutsideEnum.IllustrationDetailType = {
	Story = 2,
	Illustration = 1
}
Rouge2_OutsideEnum.LocalData = {
	Store = 5,
	Avg = 4,
	Formula = 2,
	Collection = 1,
	Illustration = 3
}
Rouge2_OutsideEnum.LocalStatData = {
	Formula = 7,
	Collection = 6
}
Rouge2_OutsideEnum.LocalDataType2PlayerKey = {
	[Rouge2_OutsideEnum.LocalData.Collection] = PlayerPrefsKey.Rouge2FavoriteCollectionRedDot,
	[Rouge2_OutsideEnum.LocalData.Formula] = PlayerPrefsKey.Rouge2FavoriteFormulaRedDot,
	[Rouge2_OutsideEnum.LocalData.Illustration] = PlayerPrefsKey.Rouge2FavoriteIllustrationRedDot,
	[Rouge2_OutsideEnum.LocalData.Avg] = PlayerPrefsKey.Rouge2FavoriteAvgRedDot,
	[Rouge2_OutsideEnum.LocalData.Store] = PlayerPrefsKey.Rouge2StoreTabRedDot,
	[Rouge2_OutsideEnum.LocalStatData.Collection] = PlayerPrefsKey.Rouge2CollectionStatRedDot,
	[Rouge2_OutsideEnum.LocalStatData.Formula] = PlayerPrefsKey.Rouge2FormulaStatRedDot
}
Rouge2_OutsideEnum.MainViewBallAudioDelay = 0.02
Rouge2_OutsideEnum.ResultFinalDisplayType = {
	Review = 1,
	Result = 2
}
Rouge2_OutsideEnum.AttributeCheckState = {
	BigSuccess = 2,
	Fail = 0,
	Success = 1
}
Rouge2_OutsideEnum.DifficultySpineCount = {
	2,
	3,
	5
}
Rouge2_OutsideEnum.MainRoleSpineScale = {
	x = 0.12,
	y = 0.12
}
Rouge2_OutsideEnum.NPCRoleSpineScale = {
	x = 0.35,
	y = 0.35
}
Rouge2_OutsideEnum.DescPercentColor = "#F0B75F"
Rouge2_OutsideEnum.DescBracketColor = "#7195DF"
Rouge2_OutsideEnum.DescReplaceColor = "#B84E32"
Rouge2_OutsideEnum.AttributeShowType = 1
Rouge2_OutsideEnum.SaveInfoViewType = {
	Edit = 2,
	EditDone = 3,
	Use = 4,
	Show = 1
}
Rouge2_OutsideEnum.BossRewardStatus = {
	HasGet = 3,
	CanGet = 2,
	Lock = 1
}
Rouge2_OutsideEnum.RemvoeSaveInfoIndex = 0
Rouge2_OutsideEnum.BossMultiplication = 1
Rouge2_OutsideEnum.BossShowHeroCount = 4
Rouge2_OutsideEnum.AnimEventName = {
	PlayAudio_Appraise = "PlayAudio_Appraise",
	RecordScore = "RecordScore"
}

return Rouge2_OutsideEnum
