-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/characterfilter/model/HeroFilterEnum.lua

module("logic.extensions.characterfilter.model.HeroFilterEnum", package.seeall)

local HeroFilterEnum = {}

HeroFilterEnum.TabType = {
	Tag = 3,
	Quality = 2,
	CareerAndColor = 1
}
HeroFilterEnum.TabTypeNameLangKey = {
	[HeroFilterEnum.TabType.CareerAndColor] = "tip_hero_filter_tab_title_career",
	[HeroFilterEnum.TabType.Quality] = "tip_hero_filter_tab_title_quality",
	[HeroFilterEnum.TabType.Tag] = "tip_hero_filter_tab_title_tag"
}
HeroFilterEnum.HeroFilterTab = {
	[CommEnum.HeroFilter.Team] = {
		HeroFilterEnum.TabType.CareerAndColor,
		HeroFilterEnum.TabType.Quality
	},
	[CommEnum.HeroFilter.Battle] = {
		HeroFilterEnum.TabType.CareerAndColor,
		HeroFilterEnum.TabType.Quality
	},
	[CommEnum.HeroFilter.HeroDepot] = {
		HeroFilterEnum.TabType.CareerAndColor,
		HeroFilterEnum.TabType.Tag
	},
	[CommEnum.HeroFilter.Roguelike] = {
		HeroFilterEnum.TabType.CareerAndColor,
		HeroFilterEnum.TabType.Quality
	},
	[CommEnum.HeroFilter.Display] = {
		HeroFilterEnum.TabType.CareerAndColor,
		HeroFilterEnum.TabType.Quality
	}
}

function HeroFilterEnum.getTypeItems(tabType)
	if not HeroFilterEnum.TabTypeItem then
		HeroFilterEnum.TabTypeItem = {
			[HeroFilterEnum.TabType.CareerAndColor] = {
				{
					isCareer = false,
					name = lang("tip_color_type_red"),
					val = GameEnum.ColorTypeEnum.Red,
					icon = CommEnum.ColorType2Icon[GameEnum.ColorTypeEnum.Red],
					iconType = IconType.Skinlib
				},
				{
					isCareer = false,
					name = lang("tip_color_type_blue"),
					val = GameEnum.ColorTypeEnum.Blue,
					icon = CommEnum.ColorType2Icon[GameEnum.ColorTypeEnum.Blue],
					iconType = IconType.Skinlib
				},
				{
					isCareer = false,
					name = lang("tip_color_type_green"),
					val = GameEnum.ColorTypeEnum.Green,
					icon = CommEnum.ColorType2Icon[GameEnum.ColorTypeEnum.Green],
					iconType = IconType.Skinlib
				},
				{
					isCareer = false,
					name = lang("tip_color_type_gray"),
					val = GameEnum.ColorTypeEnum.Gray,
					icon = CommEnum.ColorType2Icon[GameEnum.ColorTypeEnum.Gray],
					iconType = IconType.Skinlib
				},
				{
					isCareer = true,
					name = lang("tip_career_type_sentinel"),
					val = GameEnum.CareerEnum.Sentinel,
					icon = CommEnum.Career2IconNoDi[GameEnum.CareerEnum.Sentinel],
					iconType = IconType.Skinlib
				},
				{
					isCareer = true,
					name = lang("tip_career_type_assault"),
					val = GameEnum.CareerEnum.Assault,
					icon = CommEnum.Career2IconNoDi[GameEnum.CareerEnum.Assault],
					iconType = IconType.Skinlib
				},
				{
					isCareer = true,
					name = lang("tip_career_type_sniper"),
					val = GameEnum.CareerEnum.Sniper,
					icon = CommEnum.Career2IconNoDi[GameEnum.CareerEnum.Sniper],
					iconType = IconType.Skinlib
				},
				{
					isCareer = true,
					name = lang("tip_career_type_super"),
					val = GameEnum.CareerEnum.Super,
					icon = CommEnum.Career2IconNoDi[GameEnum.CareerEnum.Super],
					iconType = IconType.Skinlib
				},
				{
					isCareer = true,
					name = lang("tip_career_type_heavy"),
					val = GameEnum.CareerEnum.Heavy,
					icon = CommEnum.Career2IconNoDi[GameEnum.CareerEnum.Heavy],
					iconType = IconType.Skinlib
				},
				{
					isCareer = true,
					name = lang("tip_career_type_cure"),
					val = GameEnum.CareerEnum.Cure,
					icon = CommEnum.Career2IconNoDi[GameEnum.CareerEnum.Cure],
					iconType = IconType.Skinlib
				}
			},
			[HeroFilterEnum.TabType.Quality] = {
				{
					name = CommEnum.Quality2Name[GameEnum.QualityEnum.S],
					val = GameEnum.QualityEnum.S,
					icon = CommEnum.Quality2WordIcon[GameEnum.QualityEnum.S],
					iconType = IconType.Skinlib
				},
				{
					name = CommEnum.Quality2Name[GameEnum.QualityEnum.A],
					val = GameEnum.QualityEnum.A,
					icon = CommEnum.Quality2WordIcon[GameEnum.QualityEnum.A],
					iconType = IconType.Skinlib
				},
				{
					name = CommEnum.Quality2Name[GameEnum.QualityEnum.B],
					val = GameEnum.QualityEnum.B,
					icon = CommEnum.Quality2WordIcon[GameEnum.QualityEnum.B],
					iconType = IconType.Skinlib
				},
				{
					name = CommEnum.Quality2Name[GameEnum.QualityEnum.C],
					val = GameEnum.QualityEnum.C,
					icon = CommEnum.Quality2WordIcon[GameEnum.QualityEnum.C],
					iconType = IconType.Skinlib
				}
			}
		}

		local tagLst = {}

		for _, tagId in ipairs(HeroSortRuleConfig.instance:getDepotFilterTagIds() or {}) do
			local tagCO = ActiveSkillConfig.instance:getSkillTagCO(tagId)

			if tagCO then
				local icon = ActiveSkillConfig.instance:getTagIconName(tagCO.typeName)
				local name = string.format("<sprite name=\"%s\"> %s", icon, tagCO.name)

				table.insert(tagLst, {
					name = name,
					val = tagId
				})
			end
		end

		HeroFilterEnum.TabTypeItem[HeroFilterEnum.TabType.Tag] = tagLst
	end

	return HeroFilterEnum.TabTypeItem[tabType] or {}
end

return HeroFilterEnum
