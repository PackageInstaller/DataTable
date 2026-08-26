-- chunkname: @modules/logic/versionactivity3_6/yami/define/V3a6YaMiEnum.lua

module("modules.logic.versionactivity3_6.yami.define.V3a6YaMiEnum", package.seeall)

local V3a6YaMiEnum = _M

V3a6YaMiEnum.ConstId = {
	ProductIntervalTime = 2,
	ProductMaterialSelectMaxCount = 4,
	WorkHeroMaxCount = 5,
	PerformTime = 1,
	SavePerformTimePoint = 14,
	TrashProduct = 10,
	TalkSustainTime = 7,
	ProductSubTypeSelectMaxCount = 3,
	TalkRandomTime = 8,
	TalkMaxCount = 15
}
V3a6YaMiEnum.AttrType = {
	attr3 = 3,
	attr2 = 2,
	attr4 = 4,
	attr1 = 1
}
V3a6YaMiEnum.AttrInfo = {
	[V3a6YaMiEnum.AttrType.attr1] = {
		TxtSpriteId = 0,
		Icon = "v3a6_dormitorymode_choose_attr1",
		Name = "v3a6_yami_attr1"
	},
	[V3a6YaMiEnum.AttrType.attr2] = {
		TxtSpriteId = 1,
		Icon = "v3a6_dormitorymode_choose_attr2",
		Name = "v3a6_yami_attr2"
	},
	[V3a6YaMiEnum.AttrType.attr3] = {
		TxtSpriteId = 2,
		Icon = "v3a6_dormitorymode_choose_attr3",
		Name = "v3a6_yami_attr3"
	},
	[V3a6YaMiEnum.AttrType.attr4] = {
		TxtSpriteId = 3,
		Icon = "v3a6_dormitorymode_choose_attr4",
		Name = "v3a6_yami_attr4"
	}
}
V3a6YaMiEnum.Rating = {
	A = 3,
	C = 1,
	S = 4,
	B = 2
}
V3a6YaMiEnum.MaterialType = {
	SubType = 1,
	Material = 2
}
V3a6YaMiEnum.ResearchStatus = {
	Research = 1,
	Idle = 0,
	Pause = 2
}
V3a6YaMiEnum.GameStatus = {
	SelectedMaterial = 2,
	Performing = 4,
	SelectedHero = 3,
	Init = 1
}
V3a6YaMiEnum.MaterialInfo = {
	[V3a6YaMiEnum.MaterialType.SubType] = {
		ConstId = V3a6YaMiEnum.ConstId.ProductSubTypeSelectMaxCount
	},
	[V3a6YaMiEnum.MaterialType.Material] = {
		ConstId = V3a6YaMiEnum.ConstId.ProductMaterialSelectMaxCount
	}
}
V3a6YaMiEnum.PrefsKey = {
	Currency = "V3a6YaMiEnum_Currency_",
	MissionId = "V3a6YaMiEnum_MissionId_",
	UnlockEnterBtn = "V3a6YaMiEnum_UnlockEnterBtn_",
	HankbookProductNew = "V3a6YaMiEnum_HankbookProductNew_",
	HankbookHeroNew = "V3a6YaMiEnum_HankbookHeroNew_",
	SelectMaterials = "V3a6YaMiEnum_SelectMaterials_",
	SelectHeros = "V3a6YaMiEnum_SelectHeros_",
	LevelExp = "V3a6YaMiEnum_LevelExp_",
	UnlockMaterial = "V3a6YaMiEnum_UnlockMaterial_"
}
V3a6YaMiEnum.AnimEventName = {
	RefreshLevelExpAnim = "RefreshLevelExpAnim"
}
V3a6YaMiEnum.ResPath = {
	v3a6_dormitorymode_fundingitem = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_fundingitem.prefab",
	v3a6_dormitorymode_categoryitem = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_categoryitem.prefab",
	Talk = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_talkitem.prefab",
	v3a6_dormitorymode_employeedetailpanel = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_employeedetailpanel.prefab",
	HeroEntity = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_heroentity.prefab",
	v3a6_dormitorymode_employee_ogitem = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_employee_ogitem.prefab",
	v3a6_dormitorymode_employeeitem = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_employeeitem.prefab",
	AttrFloat = "ui/viewres/versionactivity_3_6/v3a6_dormitorymode/v3a6_dormitorymode_attritem.prefab"
}
V3a6YaMiEnum.TalkTriggerType = {
	Skill = 2,
	Random = 1
}
V3a6YaMiEnum.PerformStepType = {
	heroAttr = 2,
	productAttr = 3,
	skill = 1,
	Event = 4
}
V3a6YaMiEnum.UnlockCondition = {
	ResearchLevel = "ResearchLevel"
}
V3a6YaMiEnum.ToastId = {
	SelectMaterialsMaxCount = 365004,
	SelectHerosMaxCount = 365003,
	NoEnoughLevel = 365002,
	NoEnoughMoney = 365001
}
V3a6YaMiEnum.HeroQuality = {
	"#DBDBDB",
	"#C68CCB",
	"#E99B56"
}
V3a6YaMiEnum.HeroHandbookRowCount = 4
V3a6YaMiEnum.HeroHandbookItemHight = 280
V3a6YaMiEnum.ShowAttrFloatTime = 0.3

return V3a6YaMiEnum
