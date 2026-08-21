-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/datadef/CommEnum.lua

module("logic.common.datadef.CommEnum", package.seeall)

MainBackpackShowType = {
	CurrencyShowType = 3,
	CardChipShowType = 5,
	EquipShowType = 2,
	EchoCardPackType = 7,
	EchoShowType = 4,
	D6ShowType = 6,
	PropShowType = 1
}
MainBackpackRefreshType = {
	SelecItem = 5,
	RecycleReplied = 7,
	Filter = 2,
	ItemModel = 1,
	RecycleExit = 9,
	Sort = 3,
	RecycleEnter = 6,
	RecycleChanged = 8,
	SwitchPage = 4
}
MainBackpackSortType = {
	Quality = 2,
	Level = 1,
	Time = 3,
	Experience = 4
}
MainBackpackQuickRecycleType = {
	A = 2,
	S = 1,
	C = 4,
	B = 3
}
Quality2Lang = {
	[GameEnum.QualityEnum.S] = "tip_recyccle_orange_name",
	[GameEnum.QualityEnum.A] = "tip_recyccle_purple_name",
	[GameEnum.QualityEnum.B] = "tip_recyccle_blue_name",
	[GameEnum.QualityEnum.C] = "tip_recyccle_green_name",
	[GameEnum.QualityEnum.D] = "tip_recyccle_green_name"
}
EquipSortType2Name = {
	[CommEnum.MainBackpackSortType.Level] = "tip_sort_type_name_lv",
	[CommEnum.MainBackpackSortType.Quality] = "tip_sort_type_name_quality",
	[CommEnum.MainBackpackSortType.Time] = "tip_sort_type_name_time",
	[CommEnum.MainBackpackSortType.Experience] = "tip_sort_type_name_experience"
}
RogueSortType = {
	Attr = 1,
	Quality = 2
}
RogueSortType2Name = {
	[CommEnum.RogueSortType.Attr] = "属性总值",
	[CommEnum.RogueSortType.Quality] = "稀有度"
}
RoomBackpackShowType = {
	BuildMaterialShowType = 13,
	FurnitureShowType = 11,
	DrawingShowType = 12,
	TradeMaterialShowType = 14
}
CommonAll = 0
PropFilterType = {
	CultivateFilterType = 2,
	BaseFilterType = 1,
	TacitFilterType = 3,
	AllFilterType = 0
}
RoomFurnitureFilterType = {
	All = 0,
	Using = 2,
	NotUsing = 1
}
RoomDrawingFilterType = {
	All = 0,
	Owned = 2,
	NotOwned = 1
}
D6FilterType = {
	Part = 1,
	Attribute = 3,
	Resonance = 2
}
RoomTradeMaterialFilterType = {
	All = 0,
	Quality = 1,
	Category = 2
}
CareerFilterType = {
	All = 0,
	Sentinel = GameEnum.CareerEnum.Sentinel,
	Assault = GameEnum.CareerEnum.Assault,
	Sniper = GameEnum.CareerEnum.Sniper,
	Super = GameEnum.CareerEnum.Super,
	Heavy = GameEnum.CareerEnum.Heavy,
	Cure = GameEnum.CareerEnum.Cure,
	Grox = GameEnum.CareerEnum.Grox,
	Myth = GameEnum.CareerEnum.Myth,
	Puzzle = GameEnum.CareerEnum.Puzzle
}
QualityFilterType = {
	All = 0,
	S = GameEnum.QualityEnum.S,
	A = GameEnum.QualityEnum.A,
	B = GameEnum.QualityEnum.B,
	C = GameEnum.QualityEnum.C,
	D = GameEnum.QualityEnum.D
}
ItemUpdateState = {
	ItemDelete = 2,
	ItemUpdate = 1,
	ItemAdd = 0
}
CurrencyCodeEnum = {
	JsjjCode = 1001001,
	XwjzclCode = 1702001,
	ClawDollCoin = 1100017,
	ProtomerModulePointCode = 1199001,
	RoguelikeCoinCode = 5009001,
	InspirationSCode = 1100007,
	LzbCode = 1100003,
	XwjsCode = 1701001,
	InspirationACode = 1100008,
	CustomCode = 1,
	EchoJsjjCode = 1001002,
	HcjjCode = 1100001,
	YtjjCode = 1100002,
	XwjzhjCode = 1702002,
	AirStudioChallengeNum = 1100018,
	TlCode = 1100006,
	FallBack = 0,
	AirSutdioStoreCoinCode = 1100019,
	XwjzjtCode = 1702003
}
CurrencyItemSrc = {
	[CommEnum.CurrencyCodeEnum.FallBack] = "currency_30",
	[CommEnum.CurrencyCodeEnum.LzbCode] = "currency_10",
	[CommEnum.CurrencyCodeEnum.YtjjCode] = "currency_20",
	[CommEnum.CurrencyCodeEnum.TlCode] = "currency_30",
	[CommEnum.CurrencyCodeEnum.AirStudioChallengeNum] = "currency_40"
}
UnLockTipModule = {
	Team = 1
}
HeroFilter = {
	Display = 5,
	Roguelike = 4,
	HeroDepot = 3,
	Battle = 2,
	Team = 1
}
HeroHouseSortType = {
	Default = 1,
	WorkType = 4,
	Mood = 2,
	HouseSkill = 3
}
HouseSortType2Name = {
	[CommEnum.HeroHouseSortType.Default] = "全部",
	[CommEnum.HeroHouseSortType.Mood] = "心情",
	[CommEnum.HeroHouseSortType.HouseSkill] = "技能",
	[CommEnum.HeroHouseSortType.WorkType] = "工作状态"
}
HeroHouseFilterType = {
	NoSettled = 0,
	SecretTime = 7,
	Supervisor = 1,
	Manufacturing = 2,
	Shelter = 4,
	NormalTime = 6,
	All = -1,
	Trading = 3,
	Living = 5
}
HouseFilterType2Name = {
	[CommEnum.HeroHouseFilterType.All] = "全部",
	[CommEnum.HeroHouseFilterType.NoSettled] = "未入住",
	[CommEnum.HeroHouseFilterType.Supervisor] = "主管室工作",
	[CommEnum.HeroHouseFilterType.Manufacturing] = "制造厂工作",
	[CommEnum.HeroHouseFilterType.Trading] = "贸易站工作",
	[CommEnum.HeroHouseFilterType.Shelter] = "收容室工作",
	[CommEnum.HeroHouseFilterType.Living] = "宿舍",
	[CommEnum.HeroHouseFilterType.NormalTime] = "常规时间",
	[CommEnum.HeroHouseFilterType.SecretTime] = "密室时间"
}
HeroSortFieldType = {
	Tacit = 6,
	Quality = 4,
	Authority = 3,
	Sanity = 13,
	Default = 0,
	MaxHp = 8,
	Career = 14,
	Breakthrough = 5,
	Def = 10,
	State = 15,
	Atk = 9,
	Id = 1,
	Level = 2,
	MagicDef = 12,
	MagicAtk = 11
}
SkillDisplayCategory = {
	Passive = 7,
	Halo = 6
}
Num2RomeNum = {
	"Ⅰ",
	"Ⅱ",
	"Ⅲ",
	"Ⅳ",
	"Ⅴ"
}
AuthorityNodeType = {
	Crux = 1,
	Extra = 2,
	Normal = 0
}
SortType2LangKey = {
	[CommEnum.HeroSortFieldType.Id] = "tip_sort_type_name_id",
	[CommEnum.HeroSortFieldType.Level] = "tip_sort_type_name_lv",
	[CommEnum.HeroSortFieldType.Authority] = "tip_sort_type_name_authority",
	[CommEnum.HeroSortFieldType.Quality] = "tip_sort_type_name_quality",
	[CommEnum.HeroSortFieldType.Breakthrough] = "tip_sort_type_name_heart_anchor",
	[CommEnum.HeroSortFieldType.Tacit] = "tip_sort_type_name_tacit",
	[CommEnum.HeroSortFieldType.MaxHp] = "tip_sort_type_name_max_hp",
	[CommEnum.HeroSortFieldType.Atk] = "tip_sort_type_name_atk",
	[CommEnum.HeroSortFieldType.Def] = "tip_sort_type_name_def",
	[CommEnum.HeroSortFieldType.MagicAtk] = "tip_sort_type_name_magic_atk",
	[CommEnum.HeroSortFieldType.MagicDef] = "tip_sort_type_name_magic_def",
	[CommEnum.HeroSortFieldType.Sanity] = "tip_sort_type_name_sanity"
}
CampType2Name = {
	[0] = "所有",
	[GameEnum.CampEnum.OAD] = "天文台",
	[GameEnum.CampEnum.TreeOfEden] = "伊甸之树",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "真理",
	[GameEnum.CampEnum.SilverDawnAssociation] = "白银黎明",
	[GameEnum.CampEnum.Noah] = "诺亚",
	[GameEnum.CampEnum.StarrySkyChurch] = "星空",
	[GameEnum.CampEnum.WaterDroplets] = "水滴",
	[GameEnum.CampEnum.Grox] = "GROS",
	[GameEnum.CampEnum.Myth] = "神话",
	[GameEnum.CampEnum.None] = "无阵营"
}
CampType2SmallIcon = {
	[GameEnum.CampEnum.OAD] = "camp_logo_301",
	[GameEnum.CampEnum.TreeOfEden] = "camp_logo_302",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "camp_logo_303",
	[GameEnum.CampEnum.SilverDawnAssociation] = "camp_logo_304",
	[GameEnum.CampEnum.Noah] = "camp_logo_305",
	[GameEnum.CampEnum.StarrySkyChurch] = "camp_logo_306",
	[GameEnum.CampEnum.WaterDroplets] = "camp_logo_307",
	[GameEnum.CampEnum.None] = "camp_logo_310"
}
CampType2CharacterDepotIcon = {
	[GameEnum.CampEnum.OAD] = "smr_logo_901",
	[GameEnum.CampEnum.TreeOfEden] = "smr_logo_902",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "smr_logo_903",
	[GameEnum.CampEnum.SilverDawnAssociation] = "smr_logo_904",
	[GameEnum.CampEnum.Noah] = "smr_logo_905",
	[GameEnum.CampEnum.StarrySkyChurch] = "smr_logo_906",
	[GameEnum.CampEnum.WaterDroplets] = "smr_logo_907",
	[GameEnum.CampEnum.Grox] = "smr_logo_908",
	[GameEnum.CampEnum.None] = "smr_logo_910"
}
CampType2Icon = {
	[GameEnum.CampEnum.OAD] = "camp_logo_205",
	[GameEnum.CampEnum.TreeOfEden] = "camp_logo_207",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "camp_logo_207",
	[GameEnum.CampEnum.SilverDawnAssociation] = "camp_logo_205",
	[GameEnum.CampEnum.Noah] = "camp_logo_205",
	[GameEnum.CampEnum.StarrySkyChurch] = "camp_logo_207",
	[GameEnum.CampEnum.WaterDroplets] = "camp_logo_207",
	[GameEnum.CampEnum.None] = "camp_logo_210"
}
CampType2BigIcon = {
	[GameEnum.CampEnum.OAD] = "camp_logo_301",
	[GameEnum.CampEnum.TreeOfEden] = "camp_logo_302",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "camp_logo_303",
	[GameEnum.CampEnum.SilverDawnAssociation] = "camp_logo_304",
	[GameEnum.CampEnum.Noah] = "camp_logo_305",
	[GameEnum.CampEnum.StarrySkyChurch] = "camp_logo_306",
	[GameEnum.CampEnum.WaterDroplets] = "camp_logo_307",
	[GameEnum.CampEnum.None] = "camp_logo_310"
}
CampType2BgIcon = {
	[GameEnum.CampEnum.OAD] = "camp_logo_501",
	[GameEnum.CampEnum.TreeOfEden] = "camp_logo_502",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "camp_logo_503",
	[GameEnum.CampEnum.SilverDawnAssociation] = "camp_logo_504",
	[GameEnum.CampEnum.Noah] = "camp_logo_505",
	[GameEnum.CampEnum.StarrySkyChurch] = "camp_logo_506",
	[GameEnum.CampEnum.WaterDroplets] = "camp_logo_507",
	[GameEnum.CampEnum.None] = "camp_logo_510"
}
CampType2RgIcon = {
	[GameEnum.CampEnum.OAD] = "pt_icon_0005_01",
	[GameEnum.CampEnum.TreeOfEden] = "pt_icon_0005_02",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "pt_icon_0005_03",
	[GameEnum.CampEnum.SilverDawnAssociation] = "pt_icon_0005_04",
	[GameEnum.CampEnum.Noah] = "pt_icon_0005_05",
	[GameEnum.CampEnum.StarrySkyChurch] = "pt_icon_0005_06",
	[GameEnum.CampEnum.WaterDroplets] = "pt_icon_0005_07",
	[GameEnum.CampEnum.None] = "pt_icon_0005_10"
}
CampType2BattleIcon = {
	[GameEnum.CampEnum.OAD] = "camp_logo_101",
	[GameEnum.CampEnum.TreeOfEden] = "camp_logo_102",
	[GameEnum.CampEnum.BrotherhoodOfTruth] = "camp_logo_103",
	[GameEnum.CampEnum.SilverDawnAssociation] = "camp_logo_104",
	[GameEnum.CampEnum.Noah] = "camp_logo_105",
	[GameEnum.CampEnum.StarrySkyChurch] = "camp_logo_106",
	[GameEnum.CampEnum.WaterDroplets] = "camp_logo_107",
	[GameEnum.CampEnum.None] = "camp_logo_110"
}
Qua2Score = {
	"E",
	"D",
	"C",
	"B",
	"A",
	"S"
}
QuaLotteryBg = {
	"d",
	"c",
	"b",
	"a",
	"s"
}
Qua2Color = {
	"#9D9D9D",
	"#9D9D9D",
	"#9D9D9D",
	"#9D9D9D",
	"#f1aaf0",
	"#f4db96"
}
PropType2Name = {
	[PropFilterType.AllFilterType] = "全部",
	[PropFilterType.BaseFilterType] = "消耗品",
	[PropFilterType.CultivateFilterType] = "亲和度",
	[PropFilterType.TacitFilterType] = "思维"
}
D6Type2Name = {}
D6Attr2Name = {
	"知识",
	"敏捷",
	"力量",
	"幸运",
	"洞察",
	"沟通"
}
D6Qua2Color = {
	"#a8a8a8",
	"#90be8e",
	"#90be8e",
	"#74b9f3",
	"#c885ee",
	"#d09b56"
}
D6Qua2Score = {
	"E",
	"D",
	"C",
	"B",
	"A",
	"S"
}
D62PolygonIndex = {
	[GameEnum.PlayerCardAttributeEnum.Power] = 2,
	[GameEnum.PlayerCardAttributeEnum.Agility] = 1,
	[GameEnum.PlayerCardAttributeEnum.Knowledge] = 0,
	[GameEnum.PlayerCardAttributeEnum.Communication] = 5,
	[GameEnum.PlayerCardAttributeEnum.Insight] = 4,
	[GameEnum.PlayerCardAttributeEnum.Luck] = 3
}
FurnitureFilterType2Name = {
	[RoomFurnitureFilterType.All] = "全部",
	[RoomFurnitureFilterType.NotUsing] = "未使用",
	[RoomFurnitureFilterType.Using] = "使用中"
}
DrawingFilterType2Name = {
	[RoomDrawingFilterType.All] = "全部",
	[RoomDrawingFilterType.NotOwned] = "未获得",
	[RoomDrawingFilterType.Owned] = "已获得"
}
TradeMaterialFilterType2Name = {
	[RoomTradeMaterialFilterType.All] = "全部",
	[RoomTradeMaterialFilterType.Quality] = "品质",
	[RoomTradeMaterialFilterType.Category] = "商品类型"
}
Career2Name = {
	[0] = "所有",
	[GameEnum.CareerEnum.Sentinel] = "幻影",
	[GameEnum.CareerEnum.Assault] = "守卫",
	[GameEnum.CareerEnum.Sniper] = "狙击",
	[GameEnum.CareerEnum.Super] = "特异",
	[GameEnum.CareerEnum.Heavy] = "陨灭",
	[GameEnum.CareerEnum.Cure] = "支援",
	[GameEnum.CareerEnum.Grox] = "Grox",
	[GameEnum.CareerEnum.Myth] = "神话"
}
Career2Icon = {
	[GameEnum.CareerEnum.Sentinel] = "grid_career_101",
	[GameEnum.CareerEnum.Assault] = "grid_career_102",
	[GameEnum.CareerEnum.Sniper] = "grid_career_103",
	[GameEnum.CareerEnum.Super] = "grid_career_104",
	[GameEnum.CareerEnum.Heavy] = "grid_career_105",
	[GameEnum.CareerEnum.Cure] = "grid_career_106",
	[GameEnum.CareerEnum.Grox] = "grid_career_107",
	[GameEnum.CareerEnum.Myth] = "grid_career_108"
}
Career2IconNoDi = {
	[GameEnum.CareerEnum.Sentinel] = "grid_career_201",
	[GameEnum.CareerEnum.Assault] = "grid_career_202",
	[GameEnum.CareerEnum.Sniper] = "grid_career_203",
	[GameEnum.CareerEnum.Super] = "grid_career_204",
	[GameEnum.CareerEnum.Heavy] = "grid_career_205",
	[GameEnum.CareerEnum.Cure] = "grid_career_206"
}
Career2IconResourceExplore = {
	[GameEnum.CareerEnum.Sentinel] = "fb_adqy_101",
	[GameEnum.CareerEnum.Assault] = "fb_adqy_102",
	[GameEnum.CareerEnum.Sniper] = "fb_adqy_103",
	[GameEnum.CareerEnum.Super] = "fb_adqy_104",
	[GameEnum.CareerEnum.Heavy] = "fb_adqy_105",
	[GameEnum.CareerEnum.Cure] = "fb_adqy_106"
}
Career2TmpResName = {
	[0] = "",
	[GameEnum.CareerEnum.Sentinel] = "<sprite name=\"fhdt11\">",
	[GameEnum.CareerEnum.Assault] = "<sprite name=\"fhdt13\">",
	[GameEnum.CareerEnum.Sniper] = "<sprite name=\"fhdt12\">",
	[GameEnum.CareerEnum.Super] = "<sprite name=\"fhdt14\">",
	[GameEnum.CareerEnum.Heavy] = "<sprite name=\"fhdt17\">",
	[GameEnum.CareerEnum.Cure] = "<sprite name=\"fhdt18\">"
}
Career2IconRetrieveResult = {
	[GameEnum.CareerEnum.Sentinel] = "jscjdd_js_icon_zy5",
	[GameEnum.CareerEnum.Assault] = "jscjdd_js_icon_zy4",
	[GameEnum.CareerEnum.Sniper] = "jscjdd_js_icon_zy2",
	[GameEnum.CareerEnum.Super] = "jscjdd_js_icon_zy1",
	[GameEnum.CareerEnum.Heavy] = "jscjdd_js_icon_zy6",
	[GameEnum.CareerEnum.Cure] = "jscjdd_js_icon_zy3"
}
Quality2Name = {
	[0] = "所有",
	[GameEnum.QualityEnum.S] = "S",
	[GameEnum.QualityEnum.A] = "A",
	[GameEnum.QualityEnum.B] = "B",
	[GameEnum.QualityEnum.C] = "C",
	[GameEnum.QualityEnum.D] = "D"
}
Quality2Char = {
	[GameEnum.QualityEnum.D] = "d",
	[GameEnum.QualityEnum.C] = "c",
	[GameEnum.QualityEnum.B] = "b",
	[GameEnum.QualityEnum.A] = "a",
	[GameEnum.QualityEnum.S] = "s"
}
Quality2UpperChar = {
	[GameEnum.QualityEnum.D] = "D",
	[GameEnum.QualityEnum.C] = "C",
	[GameEnum.QualityEnum.B] = "B",
	[GameEnum.QualityEnum.A] = "A",
	[GameEnum.QualityEnum.S] = "S"
}
FilterViewQuality2Name = {
	[0] = "全部",
	[GameEnum.QualityEnum.S] = "S",
	[GameEnum.QualityEnum.A] = "A",
	[GameEnum.QualityEnum.B] = "B",
	[GameEnum.QualityEnum.C] = "C"
}
Quality2SamllIcon = {
	[GameEnum.QualityEnum.S] = "grid_head_cheng",
	[GameEnum.QualityEnum.A] = "grid_head_feng",
	[GameEnum.QualityEnum.B] = "grid_head_lan",
	[GameEnum.QualityEnum.C] = "grid_head_lv"
}
Quality2LineName = {
	[GameEnum.QualityEnum.S] = "grid_line_cheng",
	[GameEnum.QualityEnum.A] = "grid_line_feng",
	[GameEnum.QualityEnum.B] = "grid_line_lan",
	[GameEnum.QualityEnum.C] = "grid_line_lv"
}
Quality2CardBg = {
	[GameEnum.QualityEnum.S] = "bgcard_orange",
	[GameEnum.QualityEnum.A] = "bgcard_purple",
	[GameEnum.QualityEnum.B] = "bgcard_blue",
	[GameEnum.QualityEnum.C] = "bgcard_green"
}
Quality2DepotCardBg = {
	[GameEnum.QualityEnum.S] = "com_bf_0011",
	[GameEnum.QualityEnum.A] = "com_bf_0012",
	[GameEnum.QualityEnum.B] = "com_bf_0013",
	[GameEnum.QualityEnum.C] = "com_bf_0014"
}
Quality2DepotCardBg2 = {
	[GameEnum.QualityEnum.S] = "com_bf_0024",
	[GameEnum.QualityEnum.A] = "com_bf_0025",
	[GameEnum.QualityEnum.B] = "com_bf_0026",
	[GameEnum.QualityEnum.C] = "com_bf_0027"
}
Quality2DepotCardLine = {
	[GameEnum.QualityEnum.S] = "com_img_0001",
	[GameEnum.QualityEnum.A] = "com_img_0002",
	[GameEnum.QualityEnum.B] = "com_img_0003",
	[GameEnum.QualityEnum.C] = "com_img_0004"
}
Quality2RogueCardBg = {
	[GameEnum.QualityEnum.S] = "txkpz_s",
	[GameEnum.QualityEnum.A] = "txkpz_a",
	[GameEnum.QualityEnum.B] = "txkpz_b",
	[GameEnum.QualityEnum.C] = "txkpz_c"
}
Quality2ItemBg = {
	[GameEnum.QualityEnum.S] = "grid_material_5",
	[GameEnum.QualityEnum.A] = "grid_material_4",
	[GameEnum.QualityEnum.B] = "grid_material_3",
	[GameEnum.QualityEnum.C] = "grid_material_2",
	[GameEnum.QualityEnum.D] = "grid_material_1"
}
Quality2RoomOrderItemBg = {
	[GameEnum.QualityEnum.S] = "room_order_quality_s",
	[GameEnum.QualityEnum.A] = "room_order_quality_a",
	[GameEnum.QualityEnum.B] = "room_order_quality_b",
	[GameEnum.QualityEnum.C] = "room_order_quality_none",
	[GameEnum.QualityEnum.D] = "room_order_quality_none"
}
Quality2TeamSprite = {
	[-1] = "team_quality_kong",
	[GameEnum.QualityEnum.S] = "team_quality_jin",
	[GameEnum.QualityEnum.A] = "team_quality_zi",
	[GameEnum.QualityEnum.B] = "team_quality_lan",
	[GameEnum.QualityEnum.C] = "team_quality_lv"
}
Quality2WordIcon = {
	[GameEnum.QualityEnum.S] = "character_quality_s",
	[GameEnum.QualityEnum.A] = "character_quality_a",
	[GameEnum.QualityEnum.B] = "character_quality_b",
	[GameEnum.QualityEnum.C] = "character_quality_c"
}
Quality2BigIcon = {
	[GameEnum.QualityEnum.S] = "xx_big_s",
	[GameEnum.QualityEnum.A] = "xx_big_a",
	[GameEnum.QualityEnum.B] = "xx_big_b",
	[GameEnum.QualityEnum.C] = "xx_big_c"
}
Quality2HouseProductBg = {
	[GameEnum.QualityEnum.S] = "room_yield_s",
	[GameEnum.QualityEnum.A] = "room_yield_a",
	[GameEnum.QualityEnum.B] = "room_yield_b",
	[GameEnum.QualityEnum.C] = "room_yield_c"
}
Quality2NewbieTaskIcon = {
	[GameEnum.QualityEnum.S] = "zgpx_img_0001",
	[GameEnum.QualityEnum.A] = "zgpx_img_0002",
	[GameEnum.QualityEnum.B] = "zgpx_img_0003",
	[GameEnum.QualityEnum.C] = "zgpx_img_0004"
}
Quality2TipsWordIcon = {
	[GameEnum.QualityEnum.S] = "com_tips_quality_s",
	[GameEnum.QualityEnum.A] = "com_tips_quality_a",
	[GameEnum.QualityEnum.B] = "com_tips_quality_b",
	[GameEnum.QualityEnum.C] = "com_tips_quality_c"
}
ColorType2Icon = {
	[GameEnum.ColorTypeEnum.Red] = "grid_career_4",
	[GameEnum.ColorTypeEnum.Blue] = "grid_career_2",
	[GameEnum.ColorTypeEnum.Green] = "grid_career_3",
	[GameEnum.ColorTypeEnum.Gray] = "grid_career_1"
}
ColorType2Bg = {
	[GameEnum.ColorTypeEnum.Red] = "grid_career_14",
	[GameEnum.ColorTypeEnum.Blue] = "grid_career_13",
	[GameEnum.ColorTypeEnum.Green] = "grid_career_12",
	[GameEnum.ColorTypeEnum.Gray] = "grid_career_11"
}
Authority2Icon = {
	"permission_01",
	"permission_02",
	"permission_03",
	"permission_04",
	"permission_05",
	"permission_06"
}
Authority2NumIcon = {
	"authority_num_1",
	"authority_num_2",
	"authority_num_3",
	"authority_num_5",
	"authority_num_4"
}
AuthorityLv2NumIcon = {
	"qhd_num_01",
	"qhd_num_02",
	"qhd_num_03",
	"qhd_num_04",
	"qhd_num_05"
}
WeekDayMapping = {
	[0] = 7,
	7,
	1,
	2,
	3,
	4,
	5,
	6
}
SystemOpenState = {
	NotOpenState = 2,
	OverState = 3,
	OpenState = 1
}
FilterKind = {
	Sort = 0,
	CampFilter = 1,
	CareerFilter = 2,
	QualityFilter = 3
}
EquipFilterKind = {
	All = 0,
	D6Resonance = 5,
	EquipQuality = 1,
	D6Part = 4,
	D6Attr = 6,
	EquipPart = 2,
	EquipSuit = 2
}
MoneyShowType = {
	ProtomerModelUpgradeShowType3 = 25,
	HousePoachingShowType = 26,
	OnlyInspirationS = 13,
	LotteryEchoShowType = 29,
	DiamondMoneyShowType = 15,
	OnlyMoneyShowType = 3,
	OnlySkinShowType = 4,
	OnlyDiamondShowType = 4,
	DefaultHideType = 0,
	EnergyWithHint = 8,
	HouseShowType = 6,
	OnlyInspirationA = 14,
	HouseSpeedUpShowType = 31,
	EquipIntensify = 40,
	HealthExchangeShowType = 9,
	BackpackRecycleEchoShowType = 52,
	AirStudioChallengeShowType = 100,
	AirStudioChallengeShowTypeWithHint = 102,
	AirStudioStoreShowType = 101,
	OnlyEnergyWithOutAddBtn = 54,
	MaterialChapter1002 = "MaterialChapter1002",
	FurniturePartAndMoneyShowType = 19,
	BackpackRecycleShowType = 51,
	MallRoguelikeShowType = 16,
	MaterialChapter1004 = "MaterialChapter1004",
	MaterialChapter1008 = "MaterialChapter1008",
	MoneyGeneralShowType = 1,
	HouseRoomActiveShowType3 = 22,
	DiamondJsjjShowType = 27,
	ProtomerModelUpgradeShowType2 = 24,
	MaterialChapter1006 = "MaterialChapter1006",
	MaterialChapter1007 = "MaterialChapter1007",
	RoguelikeEquipShowType = 17,
	HouseRoomActiveShowType2 = 21,
	ClawDollCoin = 53,
	ProtomerModelUpgradeShowType1 = 23,
	MaterialChapter1005 = "MaterialChapter1005",
	DungeonShowType = 2,
	MaterialChapter2001 = "MaterialChapter2001",
	MaterialChapter2002 = "MaterialChapter2002",
	MaterialChapter2003 = "MaterialChapter2003",
	OnlyEnergyShowType = 7,
	BackpackShowType = 50,
	LotteryHeroShowType = 28,
	RoomUpgradeShowType = 10,
	MaterialChapter1003 = "MaterialChapter1003",
	InspirationAS = 30,
	MallShowType = 11,
	MaterialChapter1001 = "MaterialChapter1001",
	RogueVendingMachineShowType = 18,
	OnlyHcjj = 12,
	OnlyDiamondEnergyType = 5,
	HouseRoomActiveShowType1 = 20
}
CharacterSystemTab = {
	EchoItem = 4,
	Equip = 3,
	Authority = 2,
	Thinking = 5,
	Profile = 6,
	Detail = 1
}
CharacterSystemOpenView = {
	Anchor = "anchor",
	Upgrade = "upgrade",
	Tacit = "tacit"
}
CharacterSystemStringMap = {
	Detail = {
		CharacterSystemTab.Detail,
		0
	},
	Authority = {
		CharacterSystemTab.Authority,
		GameEnum.SystemEnum.RoleAffinity
	},
	Equip = {
		CharacterSystemTab.Equip,
		GameEnum.SystemEnum.RoleCarryEquip
	},
	EchoItem = {
		CharacterSystemTab.EchoItem,
		GameEnum.SystemEnum.RoleCarryEcho
	},
	Thinking = {
		CharacterSystemTab.Thinking,
		GameEnum.SystemEnum.Thought
	},
	Break = {
		CharacterSystemTab.Detail,
		GameEnum.SystemEnum.RoleBreak,
		CommEnum.CharacterSystemOpenView.Anchor
	},
	Tacit = {
		CharacterSystemTab.Detail,
		GameEnum.SystemEnum.Tacit,
		CommEnum.CharacterSystemOpenView.Tacit
	}
}
CharacterTopToastIcon = {
	Info = "com_img_0007",
	Fail = "com_img_0005",
	Succ = "com_img_0006"
}
CharacterQuality2DetailImg = {
	[GameEnum.QualityEnum.S] = "jsxx_img_0001",
	[GameEnum.QualityEnum.A] = "jsxx_img_0002",
	[GameEnum.QualityEnum.B] = "jsxx_img_0003",
	[GameEnum.QualityEnum.C] = "jsxx_img_0004"
}
CharacterQuality2DetailLetterImg = {
	[GameEnum.QualityEnum.S] = "jsxx_img_s",
	[GameEnum.QualityEnum.A] = "jsxx_img_a",
	[GameEnum.QualityEnum.B] = "jsxx_img_b",
	[GameEnum.QualityEnum.C] = "jsxx_img_c"
}
ItemQualityRes = {
	"grid_material_1",
	"grid_material_2",
	"grid_material_3",
	"grid_material_4",
	"grid_material_5"
}
SkillKindDisName = {
	"tip_skill_kind_dis_name_1",
	"tip_skill_kind_dis_name_2",
	"tip_skill_kind_dis_name_3",
	"tip_skill_kind_dis_name_4",
	"tip_skill_kind_dis_name_5",
	"tip_skill_kind_dis_name_6",
	"tip_skill_kind_dis_name_7",
	"tip_skill_kind_dis_name_8"
}
UnlockType = {
	Face = 2,
	Past = 1,
	Voice = 3,
	Wake = 4
}
PropSubType = {
	PowerProp = 2,
	AirtightTimeProp = 11,
	TacitProp = 7,
	UpRightProp = 4,
	CardExpProp = 3,
	ThinkProp = 5,
	LotteryCardProp = 1,
	GiftBoxProp = 8,
	EquipmentProp = 6
}
HeroItemSubType = {
	NormalHeartAnchor = 3,
	HeroChip = 2,
	HeroHeartAnchor = 1,
	NormalChip = 4
}
QualityColorType = {
	[GameEnum.QualityEnum.S] = "#faac3e",
	[GameEnum.QualityEnum.A] = "#ef3efa",
	[GameEnum.QualityEnum.B] = "#3ed6fa",
	[GameEnum.QualityEnum.C] = "#3efa9e"
}
MainUIMode = {
	JoystickMode = 2,
	NormalMode = 1
}
ConditionType = {
	HERO_LV = "heroLv",
	LEVEL = "level",
	HERO_POWER_LV = "powerLv",
	HERO_BREAK_LV = "breakLv",
	HERO_TACIT_LV = "tacitLv",
	HAS_HERO_AND_LEVEL_GREATER = "characterLv"
}
DungeonType = {
	Teaching = 6,
	HeroEarlyAccess = 16,
	Mainline = 1,
	Tacit = 2,
	Exp = 9,
	LightTower = 10,
	Material = 4,
	Branchline = 12,
	DarkTower = 11,
	EquipExplore = 7,
	ControlAction = 13,
	ControlActionTeaching = 14,
	Gold = 8,
	Preface = 5,
	PowerChallenge = 17,
	Any = 0
}
AnDingType = {
	Gold = 8,
	Exp = 9,
	Material = 4
}
EquipPartType = {
	All = 0,
	Defense = 2,
	Assist = 1,
	Special = 3
}
EquipPartName = {
	[EquipPartType.All] = "全部",
	[EquipPartType.Assist] = "辅助",
	[EquipPartType.Defense] = "防御",
	[EquipPartType.Special] = "特殊"
}
EquipPartIcon = {
	[EquipPartType.Assist] = "equipment_sign_1",
	[EquipPartType.Defense] = "equipment_sign_2",
	[EquipPartType.Special] = "equipment_sign_3"
}
EquipRecycleType = {
	Extract = 1,
	Decompose = 2
}
D6PartType = {
	Weapon = 1,
	All = 0,
	Armor = 2,
	Decorations = 3
}
D6PartName = {
	[D6PartType.All] = "全部",
	[D6PartType.Weapon] = "武器",
	[D6PartType.Armor] = "防具",
	[D6PartType.Decorations] = "饰品"
}
D6Part2IconKey = {
	[D6PartType.Weapon] = "D6IconForPart1",
	[D6PartType.Armor] = "D6IconForPart2",
	[D6PartType.Decorations] = "D6IconForPart3"
}
D6ResonanceType = {
	Resonance1 = 1,
	All = 0,
	Resonance2 = 2,
	Resonance3 = 3
}
NavMeshRadius = {
	Common = 0.2,
	EnterElevator = 0.05
}
NavMeshAgentSpeed = {
	HeroWalk = 1.3,
	HeroRun = 2.5,
	MasterWalk = 8,
	RobotWalk = 1.3
}
LotteryCardQualityColor = {
	[GameEnum.QualityEnum.S] = "#d2833a",
	[GameEnum.QualityEnum.A] = "#8a71d8",
	[GameEnum.QualityEnum.B] = "#3c89a5",
	[GameEnum.QualityEnum.C] = "#6c9c80"
}
TimeLineTagName = {
	AnimationEnd = "animation_end"
}
MonumentFilterType = {
	Type1 = 1,
	All = 0,
	Type2 = 2
}
AnchorEnum = {
	Bottom = 7,
	Top = 1,
	TopLeft = 0,
	BottomRight = 8,
	TopRight = 2,
	Right = 5,
	BottomLeft = 6,
	Left = 3,
	Center = 4
}
TipsIconType = {
	Common = 0,
	Monument = 1
}
RewardEnum = {
	CanNotGot = 1,
	CanGot = 2,
	HasGot = 3
}
HandBookSubView = {
	Monster = 5,
	Plot = 3,
	CG = 2,
	Music = 7,
	RelationShip = 1,
	Alienation = 6,
	Record = 4
}
PlayerCreateSubView = {
	Model = 2,
	Name = 1,
	Six = 3
}
PlayerNameCreateState = {
	Default = 0,
	Space = 2,
	DefaultUsed = 5,
	Special = 3,
	Long = 4,
	Normal = 1
}
PlayerNameState2Color = {
	[0] = "#d1d1d1",
	"#f9f9f9",
	"#bf404a",
	"#bf404a",
	"#bf404a",
	"#bf404a"
}
BackPackItemSignTyp = {
	Get = 8,
	Activity = 7,
	Extra = 5,
	First = 2,
	FixDrop = 10,
	Star = 9,
	LimitTime = 4,
	MultipleDropDouble = 13,
	MultipleDropTrible = 14,
	Probability = 6,
	SmallProbabilityDrop = 11,
	Main = 3,
	RecommendSign = 12,
	None = 1
}
BackPackFilterViewStatus = {
	Decompose = 2,
	Extract = 3,
	Normal = 1
}
BackPackFilterItemStatus = {
	Disable = 3,
	Hide = 4,
	Select = 2,
	Normal = 1
}
CharacterSkillType = {
	Type9 = 9,
	Type5 = 5,
	Type10 = 10,
	Type4 = 4,
	Type3 = 3,
	Type11 = 11,
	Type2 = 2,
	Type1 = 1,
	Type8 = 8,
	Type7 = 7,
	Type6 = 6
}
NoShowInGainViewItem = {
	[1100011] = 1
}
BuryPointType = {
	PlayerCreate = 501349,
	Story = 501487,
	MallOpen = 501510,
	Guide = 501336,
	ActivityTabClick = 501801,
	FirstRecharge = 501509
}
ActivityTabClickKey = {
	secondTabName = "spx_secondTabName",
	btnName = "spx_btnName",
	firstTabName = "spx_firstTabName"
}
BuryPointPlayerCreateKey = {
	OpenAttributeTime = "spx_createPlayerOpenAttributeTime",
	SetName = "spx_createPlayerSetName",
	AnswerTwo = "spx_createPlayerAnswerTwo",
	RoleTmpId = "spx_createPlayerRoleTmpId",
	CommitTotalTime = "spx_createPlayerCommitTotalTime",
	PlayerNickname = "spx_createPlayerNickname",
	CommitAttributeTime = "spx_createPlayerCommitAttributeTime",
	PlayerImage = "spx_createPlayerImage",
	AnswerOne = "spx_createPlayerAnswerOne",
	PlayerAttribute = "spx_createPlayerAttribute",
	OpenImageTime = "spx_createPlayerOpenImageTime"
}
BuryPointStoryKey = {
	StoryFbId = "spx_storyFbId",
	StoryTime = "spx_storyTime",
	StorySkip = "spx_storySkip",
	StoryId = "spx_storyId"
}
BuryPointGuideKey = {
	GuideState = "spx_guideState",
	GuideLastStepId = "spx_guideLastStepId",
	GuideType = "spx_guideType",
	GuideFinishType = "spx_guideFinishType",
	GuideId = "spx_guideId"
}
BuryPointAccumulateRechargeKey = {
	RechargeReachCredit = "spx_accumulateRechargeReachCredit",
	RechargeTakeId = "spx_accumulateRechargeTakeId",
	RechargeReachId = "spx_accumulateRechargeReachId",
	RechargeTakenIds = "spx_accumulateRechargeTakenIds",
	RechargeTakeCredit = "spx_accumulateRechargeTakeCredit"
}
BuryPointFirstRechargeKey = {
	RechargeJump = "spx_firstRechargeJump",
	StayTime = "spx_firstRechargeStayTime"
}
BuryPointMallOpenKey = {
	OpenTagName = "spx_mallOpenTagName"
}
ManualKey = {
	RogueExplore = 5004,
	RogueRectify = 5005,
	RogueTask = 5001,
	RogueStore = 5012,
	Mail = 1002,
	RogueEncounter = 5010,
	RogueMeetEvent = 5006,
	RogueTeamDetail = 5015,
	RogueEquipTips = 5017,
	RogueExtraTips = 5018,
	AirtightTimeTips = 5021,
	RogueEquip = 5002,
	RogueSingle = 5008,
	RogueMult = 5009,
	RogueMeetMonster = 5007,
	RogueGuess = 5013,
	RogueProp = 5016,
	RogueSelectRole = 5003,
	RogueMoony = 5014,
	RogueFight = 5011
}
ItemChangeClientOptType = {
	BattleIn = 10001,
	HeroOnly = 10002
}
TalentSkillAwakeStatus = {
	Locked = 2,
	Unlock = 3,
	None = 1
}
ItemOnlyShowSubType = {
	SkillItem = 1
}
TreasureItemSubType = {
	Random = 2,
	Fixed = 3,
	Choose = 1
}
TipsPopType = {
	Top = 1,
	Right = 3,
	Bottom = 2,
	Left = 4
}
TipsAlignType = {
	Down = 2,
	Up = 1,
	Right = 3,
	Left = 4
}
ImageEnum = {
	Boy = 0,
	Girl = 1
}
DisplayCardEnum = {
	Card = 2,
	Frame = 3,
	Mask = 1
}
RoomBackPackSortType = {
	Atmosphere = 1,
	None = 0
}
EffectSize = {
	Part = 2,
	MaxSceneEffect = 4,
	FullScreen = 3,
	Small = 1
}
ItemRedPoint = {
	New = 1,
	AvailableGiftBag = 2,
	AvailableExpire = 4
}
RedPointIconType = {
	New = 4,
	Num = 3,
	Weak = 1,
	Strong = 2
}
MultiFunctionDataType = {
	AuthorityUp = 2,
	EquipStrengthen = 3,
	EchoBreak = 4,
	AuthoritySkillEnhance = 5
}
CharacterQuality2TabIcon = {
	[GameEnum.QualityEnum.S] = "jscx_tab_s",
	[GameEnum.QualityEnum.A] = "jscx_tab_a",
	[GameEnum.QualityEnum.B] = "jscx_tab_b",
	[GameEnum.QualityEnum.C] = "jscx_tab_c"
}
Quality2AirStoreBg = {
	[GameEnum.QualityEnum.S] = "slmmy_bf_zxdh_golden",
	[GameEnum.QualityEnum.A] = "slmmy_bf_zxdh_purple",
	[GameEnum.QualityEnum.B] = "slmmy_bf_zxdh_blue",
	[GameEnum.QualityEnum.C] = "slmmy_bf_zxdh_green",
	[GameEnum.QualityEnum.D] = "slmmy_bf_zxdh_green"
}
GuideID = {
	EquipTiming = 7108,
	CharacterMain = 7104,
	EquipMain = 7105,
	PlayerMain = 7110,
	Anchor = 7101,
	EquipTimingReset = 7109,
	AirtightRoomTime = 7112,
	EquipRetiming = 7107,
	SixDimension = 1004,
	Impression = 7103,
	PlayerAchievement = 7111,
	AirWorkShop = 7113,
	PlayerStatus = 7119,
	EquipLvUp = 7106,
	CarryItem = 7102,
	AirWorkShopRodeo = 7118
}
RankEnum = {
	Collection = 2,
	ClimbTower = 4,
	AirWorkShopFreeEndless = 0,
	AirWorkShop = 5,
	MainLine = 6,
	Level = 3,
	FOOTBALL = 1
}
CharacterDetailType = {
	OtherUser = 2,
	Rank = 3,
	Oneself = 1
}
