-- chunkname: @/tmp/or_script/lua_compile/dm/assets/GameStyle.lua

require("dm.gameplay.develop.model.hero.skill.SkillAttribute")

GameStyle = GameStyle or {}
ItemTipsViewTag = 10009
EquipTipsViewTag = 10010
BuffTipsViewTag = 10011
SomeWordTipsViewTag = 10012
ItemBuffTipsViewTag = 10013
ItemShowTipsViewTag = 10014
ComposeToEquipTipsViewTag = 10015
TSoulTipsViewTag = 10016
MessageViewTag = 10017
GameStyle.touchEffectZorder = 9999
BuffTypeSet = {
	NormalBlock = "NormalBlock",
	HeroStory = "HeroStory",
	SPBlock = "SPBlock",
	EliteBlock = "EliteBlock"
}
ColorType = {
	kPurple = 4,
	kRed = 6,
	kWhite = 1,
	kBlock = 7,
	kOrange = 5,
	kBlue = 3,
	kGreen = 2
}
ClimateType = {
	Sunshine = "Sunshine",
	Overcast = "Overcast",
	RainS = "RainS",
	Mist = "Mist",
	Rain = "Rain",
	Cloudy = "Cloudy",
	Snow = "Snow",
	SnowS = "SnowS"
}
Climate2LayerName = {
	RainS = "Weather",
	Overcast = "Weather",
	Snow = "Weather",
	Rain = "Weather",
	Light = "Weather",
	SnowS = "Weather"
}
Climate2MCName = {
	RainS = "xiayuss_xiayu",
	Overcast = "shandian_shandian",
	Snow = "xiaxue_xiaxue",
	Rain = "xiayu_xiayu",
	Light = "jiguangtu_jiguang",
	SnowS = "xiaxues_xiaxue"
}
ClimateSoundId = {
	Sunshine = "_50",
	Overcast = "_51",
	RainS = "_52",
	Mist = "_51",
	Rain = "_52",
	Cloudy = "_51",
	Snow = "_51",
	SnowS = "_51"
}
Climate2AudioEffect = {
	Rain = "Se_Effect_Rain",
	RainS = "Se_Effect_Rain"
}

local colorArr = {
	cc.c3b(255, 255, 255),
	cc.c3b(205, 250, 100),
	cc.c3b(165, 220, 245),
	cc.c3b(200, 175, 245),
	cc.c3b(250, 200, 125),
	cc.c3b(210, 70, 70),
	cc.c3b(133, 133, 133),
	cc.c3b(237, 202, 130),
	cc.c3b(255, 252, 0),
	cc.c3b(251, 236, 99),
	cc.c3b(80, 50, 20),
	cc.c3b(130, 120, 100),
	cc.c3b(197, 170, 170),
	[13] = cc.c3b(195, 195, 195)
}

function GameStyle:getColor(level)
	return colorArr[level]
end

function GameStyle:stringToColor(str)
	local str_r = "0x" .. string.sub(str, 2, 3)
	local str_g = "0x" .. string.sub(str, 4, 5)
	local str_b = "0x" .. string.sub(str, 6, 7)
	local r = string.format("%d", tonumber(str_r))
	local g = string.format("%d", tonumber(str_g))
	local b = string.format("%d", tonumber(str_b))

	return cc.c3b(r, g, b)
end

local skillTypeColor = {
	NORMAL = cc.c3b(255, 255, 255),
	SPECIAL = cc.c3b(255, 255, 255),
	BATTLEPASSIVE = cc.c3b(255, 255, 255),
	PASSIVE = cc.c3b(255, 255, 255),
	UNIQUE = cc.c3b(255, 255, 255),
	PROUD = cc.c3b(255, 255, 255)
}

function GameStyle:getSkillTypeColor(skillType)
	return skillTypeColor[skillType] or skillTypeColor.NORMAL
end

function GameStyle:setYellowTextEffect(text, style)
	style = style or {}

	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 247, 176, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 186, 88, 255)
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text:enableOutline(cc.c4b(83, 44, 38, 255), 2)
end

function GameStyle:getDefaultUnfoundFile()
	return "asset/items/item_200001.png"
end

local rangeMap = {}

function GameStyle:setHeroAtkRangeImage(targetNode, type)
	if not rangeMap[type] then
		targetNode:loadTexture(rangeMap[type], 1)
	end
end

IconShape = {
	kQuadrangle = "quadrangle",
	kParallelogram = "parallelogram"
}

local kMasterQualityRectArr = {
	"pic_baise_pzk_sms.png",
	"pic_lvse_pzk_sms.png",
	"pic_lanse_pzk_sms.png",
	"pic_zise_pzk_sms.png",
	"pic_huangse_pzk_sms.png",
	"pic_hongse_pzk_sms.png"
}
local masterIconBottomArr = {
	"pic_baise_di_pzk_sms.png",
	"pic_lvse_di_pzk_sms.png",
	"pic_lanse_di_pzk_sms.png",
	"pic_zise_di_pzk_sms.png",
	"pic_huangse_di_pzk_sms.png",
	"pic_hongse_di_pzk_sms.png"
}
local kMasterQualityBattleRectArr = {
	"pic_baise_sms.png",
	"pic_lvse_sms.png",
	"pic_lanse_sms.png",
	"pic_zise_sms.png",
	"pic_huangse_sms.png",
	"pic_hongse_sms.png"
}
local masterIconBattleBottomArr = {
	"pic_baise_di_sms.png",
	"pic_lvse_di_sms.png",
	"pic_lanse_di_sms.png",
	"pic_zise_di_sms.png",
	"pic_huangse_di_sms.png",
	"pic_hongse_di_sms.png"
}
local masterSkillQualityRectArr = {
	"pic_baise_pzk_jn.png",
	"pic_lvse_pzk_jn.png",
	"pic_lanse_pzk_jn.png",
	"pic_zise_pzk_jn.png",
	"pic_chengse_pzk_jn.png",
	"pic_hongse_pzk_jn.png"
}
local masterSkillQualityBottomArrEx = {
	"pic_baise_di_pzk_zb.png",
	"pic_lvse_di_pzk_zb.png",
	"pic_lanse_di_pzk_zb.png",
	"pic_zise_di_pzk_zb.png",
	"pic_huangse_di_pzk_zb.png",
	"pic_hongse_di_pzk_zb.png"
}
local masterSkillQualityRectArrEx = {
	"pic_baise_pzk_zb.png",
	"pic_lvse_pzk_zb.png",
	"pic_lanse_pzk_zb.png",
	"pic_zise_pzk_zb.png",
	"pic_huangse_pzk_zb.png",
	"pic_hongse_pzk_zb.png"
}
local masterHeadType = {
	kMiddle = "/masterbattlepic_",
	kSmall = "/masterheadpic_"
}

function GameStyle:getMasterHeadFile(id, headType)
	headType = headType or masterHeadType.kSmall

	return "asset/master/" .. id .. headType .. id .. ".png"
end

local kCnStrArr = {
	[0] = "",
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九"
}

function GameStyle:intNumToCnString(num)
	num = tonumber(num)

	if num and num > 0 and num < 100 then
		local d1 = num % 10
		local d2 = (num - d1) * 0.1

		return ((d2 >= 1 or nil) and (((d2 > 1 or nil) and (kCnStrArr[d2] or "")) .. "十" or "")) .. kCnStrArr[d1]
	elseif num == 0 then
		return "零"
	else
		return ""
	end
end

local kCnStrArr = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X"
}

function GameStyle:intNumToRomaString(num)
	return kCnStrArr[num] or ""
end

local kWeekStrArr = {
	Strings:get("SYSTEM_UI_DATE1"),
	Strings:get("SYSTEM_UI_DATE2"),
	Strings:get("SYSTEM_UI_DATE3"),
	Strings:get("SYSTEM_UI_DATE4"),
	Strings:get("SYSTEM_UI_DATE5"),
	Strings:get("SYSTEM_UI_DATE6"),
	Strings:get("SYSTEM_UI_DATE7")
}

function GameStyle:intNumToWeekString(num)
	num = tonumber(num)

	return kWeekStrArr[num] or ""
end

local masterQualityRectFile = "asset/master/masterRect/masterSkillQuaRect/"

function GameStyle:getMasterSkillQualityRectFile(quality)
	return masterQualityRectFile .. masterSkillQualityRectArr[quality] or self:getDefaultUnfoundFile()
end

local masterQualityBottomFileEx = "asset/heroRect/equipBottomRect/"

function GameStyle:getMasterSkillQualityBottomFileEx(quality)
	return masterQualityBottomFileEx .. masterSkillQualityBottomArrEx[quality] or self:getDefaultUnfoundFile()
end

local masterQualityRectFileEx = "asset/master/masterRect/masterSkillQuaRect/"

function GameStyle:getMasterSkillQualityRectFileEx(quality)
	return masterQualityRectFileEx .. masterSkillQualityRectArrEx[quality] or self:getDefaultUnfoundFile()
end

local masterQualityRectFile = "asset/heroRect/heroQuaRect/"

function GameStyle:getMasterQualityRectFile(quality, isRect)
	if isRect then
		return "asset/heroRect/heroBattleRect/" .. kMasterQualityBattleRectArr[quality]
	end

	return masterQualityRectFile .. kMasterQualityRectArr[quality] or self:getDefaultUnfoundFile()
end

local masterBottomFile = "asset/heroRect/heroBottomRect/"

function GameStyle:getMasterIconBottomFile(quality, isRect)
	if isRect then
		return "asset/heroRect/heroBattleRect/" .. masterIconBattleBottomArr[quality]
	end

	return masterBottomFile .. masterIconBottomArr[quality]
end

local masterSkillIconFile = "asset/master/masterRect/masterSkillIcon/"

function GameStyle:getMasterSkillIconFile(id)
	return masterSkillIconFile .. "pic_zhujuejineng_jn.png" or self:getDefaultUnfoundFile()
end

local heroRarityArr = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"yh_bg_n.png",
	"yh_bg_r.png",
	"yh_bg_sr.png",
	"yh_bg_ssr.png",
	"yh_bg_sp.png"
}
local getHeroRarityAnimPos = {
	[17] = {
		18,
		13
	},
	[16] = {
		22,
		10
	},
	[15] = {
		22,
		10
	},
	[14] = {
		22,
		10
	},
	[13] = {
		23,
		12
	},
	[12] = {
		18,
		12
	},
	[11] = {
		18,
		12
	}
}
local getHeroRarityBgScaleX = {
	[11] = 0.8,
	[15] = 1.1,
	[16] = 1.1,
	[17] = 0.95,
	[12] = 0.8,
	[13] = 0.95,
	[14] = 1.1
}

function GameStyle:getHeroRarityImage(rarity)
	return heroRarityArr[rarity] or "yh_bg_n.png"
end

function GameStyle:getHeroRarityImage1(rarity)
	local var_18_0 = {
		scale = 0.35
	}

	var_18_0.img = heroRarityArr[rarity] or "yh_bg_n.png"

	return var_18_0, getHeroRarityAnimPos[rarity], getHeroRarityBgScaleX[rarity]
end

local heroRarityWearSound = {
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"_25",
	"_25",
	"_64",
	"_64",
	"_64"
}

function GameStyle:getHeroRaritySound(rarity)
	return heroRarityWearSound[tonumber(rarity)]
end

local heroRarityTextArr = {
	[11] = "N",
	[15] = Strings:get("Hero_Rarity_UR"),
	[14] = Strings:get("Hero_Rarity_SSR"),
	[13] = Strings:get("Hero_Rarity_SR"),
	[12] = Strings:get("Hero_Rarity_R")
}

function GameStyle:getHeroRarityText(rarity)
	return heroRarityTextArr[tonumber(rarity)] or "N"
end

local heroOccupatioFile = "asset/heroRect/heroOccupation/%s.png"

function GameStyle:getHeroOccupation(type)
	local occupation = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Hero_Type", "content")
	local name = Strings:get(occupation[type][1])
	local image = string.format(heroOccupatioFile, occupation[type][2])

	return name, image
end

local battleHeroOccupationIcons = {
	Aoe = "xk_fashi.png",
	Attack = "xk_gongxi.png",
	Defense = "xk_shouhu.png",
	Curse = "xk_zhoushu.png",
	Support = "xk_fuzhu.png",
	Summon = "xk_zhaohuan.png",
	Cure = "xk_zhiyu.png"
}

function GameStyle:getBatleHeroOccupation(type)
	local occupation = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Hero_Type", "content")
	local name = Strings:get(occupation[type][1])
	local image = battleHeroOccupationIcons[type]
	local imageType = ccui.TextureResType.plistType

	return name, image, imageType
end

function GameStyle:getHeroBgByQuality(quality)
	if quality <= 19 then
		return {
			"kazu_bg_ka_bai.png",
			"kazu_bg_ka_baixingji.png",
			"kazu_bg_ka_bai_2_new.png",
			"kazu_bg_ka_bai_new.png",
			"kazu_bg_ka_baixingji_new.png"
		}
	elseif quality >= 20 and quality < 30 then
		return {
			"kazu_bg_ka_lv.png",
			"kazu_bg_ka_lvxingji.png",
			"kazu_bg_ka_lv_2_new.png",
			"kazu_bg_ka_lv_new.png",
			"kazu_bg_ka_lvxingji_new.png"
		}
	elseif quality >= 30 and quality < 40 then
		return {
			"kazu_bg_ka_lan.png",
			"kazu_bg_ka_lanxingji.png",
			"kazu_bg_ka_lan_2_new.png",
			"kazu_bg_ka_lan_new.png",
			"kazu_bg_ka_lanxingji_new.png"
		}
	elseif quality >= 40 and quality < 50 then
		return {
			"kazu_bg_ka_zi.png",
			"kazu_bg_ka_zixingji.png",
			"kazu_bg_ka_zi_2_new.png",
			"kazu_bg_ka_zi_new.png",
			"kazu_bg_ka_zixingji_new.png"
		}
	elseif quality >= 50 and quality < 60 then
		return {
			"kazu_bg_ka_cheng.png",
			"kazu_bg_ka_chengxingji.png",
			"kazu_bg_ka_cheng_2_new.png",
			"kazu_bg_ka_cheng_new.png",
			"kazu_bg_ka_chengxingji_new.png"
		}
	elseif quality >= 60 then
		return {
			"kazu_bg_ka_hong.png",
			"kazu_bg_ka_hongxingji.png",
			"kazu_bg_ka_hong_2_new.png",
			"kazu_bg_ka_hong_new.png",
			"kazu_bg_ka_hongxingji_new.png"
		}
	end
end

function GameStyle:getHeroQualityRectFile(quality)
	local path = "asset/heroRect/heroIconRect/"
	local image = self:getHeroBgByQuality(quality)

	if image then
		return {
			path .. image[1],
			path .. image[2],
			path .. image[3],
			path .. image[4],
			path .. image[5]
		}
	end
end

local kHeroRarityBgFile = "asset/commonRaw/"
local kHeroRarityBg = {
	[11] = {
		kHeroRarityBgFile .. "common_bd_r01.png",
		kHeroRarityBgFile .. "common_bd_r02.png"
	},
	[12] = {
		kHeroRarityBgFile .. "common_bd_r01.png",
		kHeroRarityBgFile .. "common_bd_r02.png"
	},
	[13] = {
		kHeroRarityBgFile .. "common_bd_sr01.png",
		kHeroRarityBgFile .. "common_bd_sr02.png"
	},
	[14] = {
		kHeroRarityBgFile .. "common_bd_ssr01.png",
		kHeroRarityBgFile .. "common_bd_ssr02.png"
	},
	[15] = {
		kHeroRarityBgFile .. "common_bd_sp01.png",
		kHeroRarityBgFile .. "common_bd_sp02.png"
	}
}

function GameStyle:getHeroRarityBg(rarity)
	return kHeroRarityBg[rarity]
end

function GameStyle:getHeroNameColorByQuality(quality)
	if quality <= 19 then
		return {
			color = cc.c3b(255, 255, 254),
			outline = cc.c4b(0, 0, 0, 219.29999999999998)
		}
	elseif quality >= 20 and quality < 30 then
		return {
			color = cc.c3b(189, 250, 85),
			outline = cc.c4b(0, 0, 0, 219.29999999999998)
		}
	elseif quality >= 30 and quality < 40 then
		return {
			color = cc.c3b(79, 199, 255),
			outline = cc.c4b(0, 0, 0, 219.29999999999998)
		}
	elseif quality >= 40 and quality < 50 then
		return {
			color = cc.c3b(215, 75, 255),
			outline = cc.c4b(0, 0, 0, 219.29999999999998)
		}
	elseif quality >= 50 and quality < 60 then
		return {
			color = cc.c3b(255, 159, 48),
			outline = cc.c4b(0, 0, 0, 219.29999999999998)
		}
	elseif quality >= 60 then
		return {
			color = cc.c3b(255, 76, 77),
			outline = cc.c4b(0, 0, 0, 219.29999999999998)
		}
	end
end

function GameStyle:setHeroNameByQuality(text, quality, width)
	text:disableEffect(1)
	text:setColor(self:getHeroNameColorByQuality(quality).color)
	text:enableOutline(self:getHeroNameColorByQuality(quality).outline, width or 1)
end

function GameStyle:getHeroQualityImgByQuality(quality)
	if quality <= 19 then
		return "yh_bg_lj_1.png"
	elseif quality >= 20 and quality < 30 then
		return "yh_bg_lj_2.png"
	elseif quality >= 30 and quality < 40 then
		return "yh_bg_lj_3.png"
	elseif quality >= 40 and quality < 50 then
		return "yh_bg_lj_4.png"
	elseif quality >= 50 and quality < 60 then
		return "yh_bg_lj_5.png"
	elseif quality >= 60 then
		return "yh_bg_lj_6.png"
	end
end

function GameStyle:setBtnClickEffect(btn, clickFunc, checkFunc)
	style = style or {}

	btn:setTouchEnabled(true)
	btn:setSwallowTouches(false)
	btn:addTouchEventListener(function(sender, eventType)
		sender.initScale = sender.initScale or sender:getScale()

		local initScale = sender.initScale

		if eventType == ccui.TouchEventType.began then
			sender._touchDistance = 0
			sender._beganPos = sender:getTouchBeganPosition()

			if btn.action then
				return
			end

			btn.action = true

			local sequense = cc.Sequence:create(cc.ScaleTo:create(0.1, initScale - 0.05), cc.CallFunc:create(function()
				return
			end))

			btn:runAction(sequense)
		elseif eventType == ccui.TouchEventType.canceled then
			local sequense = cc.Sequence:create(cc.ScaleTo:create(0.1, initScale), cc.CallFunc:create(function()
				btn.action = false
			end))

			btn:runAction(sequense)

			sender._touchDistance = 0
		elseif eventType == ccui.TouchEventType.moved then
			-- block empty
		elseif eventType == ccui.TouchEventType.ended then
			local endPosition = sender:getTouchEndPosition()
			local posX = math.abs(endPosition.x - sender._beganPos.x)
			local posY = math.abs(endPosition.y - sender._beganPos.y)

			sender._touchDistance = math.max(posX, posY)

			local sequense = cc.Sequence:create(cc.ScaleTo:create(0.1, initScale), cc.CallFunc:create(function()
				btn.action = false
			end))

			btn:runAction(sequense)

			sender._touchDistance = sender._touchDistance or 0

			if sender._touchDistance < 25 then
				local checkFactor = true
				local checkFactor

				if checkFunc then
					checkFactor = checkFunc and checkFunc(sender)
				end

				if clickFunc and checkFactor then
					clickFunc(sender, eventType)
				end
			end

			sender._touchDistance = 0
		end
	end)
end

local equipRarityRectFile = "asset/itemRect/"
local EquipRarityRect = {
	[11] = equipRarityRectFile .. "common_pz_lv.png",
	[12] = equipRarityRectFile .. "common_pz_lan.png",
	[13] = equipRarityRectFile .. "common_pz_zi.png",
	[14] = equipRarityRectFile .. "common_pz_huang.png",
	[15] = equipRarityRectFile .. "common_pz_hong.png"
}

function GameStyle:getEquipRarityRectFile(rarity)
	return EquipRarityRect[tonumber(rarity)]
end

local EquipRarityRectFlash = {
	[15] = "ur_anime_urequipeff"
}

function GameStyle:getEquipRarityRectFlashFile(rarity)
	return EquipRarityRectFlash[tonumber(rarity)] or EquipRarityRectFlash[11]
end

local heroRect = ASSET_LANG_COMMON
local equipRarityArr = {
	[11] = heroRect .. "common_img_n.png",
	[12] = heroRect .. "common_img_r.png",
	[13] = heroRect .. "common_img_sr.png",
	[14] = heroRect .. "common_img_ssr.png",
	[15] = heroRect .. "common_img_UR_min.png"
}

function GameStyle:getEquipRarityImage(rarity)
	return equipRarityArr[tonumber(rarity)] or equipRarityArr[11]
end

local equipRarityFlash = {
	[15] = "ur_01_anime_urequipeff"
}

function GameStyle:getEquipRarityFlash(rarity)
	return equipRarityFlash[tonumber(rarity)] or equipRarityFlash[15]
end

local relationPicPath = {
	{
		"jb_bg_lv.png",
		"jb_bg_lv_2.png"
	},
	{
		"jb_bg_lan.png",
		"jb_bg_lan_2.png"
	},
	{
		"jb_bg_zi.png",
		"jb_bg_zi_2.png"
	},
	{
		"jb_bg_ju.png",
		"jb_bg_ju_2.png"
	},
	{
		"jb_bg_hong.png",
		"jb_bg_hong_2.png"
	}
}

function GameStyle:getRelationPic(level)
	return relationPicPath[level]
end

local itemRectPath = "asset/itemRect/"
local itemQuaRoundPath = {
	"pinzhikuang_1.png",
	"pinzhikuang_2.png",
	"pinzhikuang_3.png",
	"pinzhikuang_4.png",
	"pinzhikuang_5.png",
	"pinzhikuang_6.png"
}
local itemQuaPatternPath = {
	"common_pz_bai.png",
	"common_pz_lv.png",
	"common_pz_lan.png",
	"common_pz_zi.png",
	"common_pz_huang.png",
	"common_pz_hong.png",
	"common_pz_sp.png"
}
local kItemImgType = {
	Pattern = 1,
	Round = 2
}

function GameStyle:getItemQuaRectFile(qua, quaImgType)
	if quaImgType then
		if quaImgType == kItemImgType.Round then
			return itemRectPath .. itemQuaRoundPath[qua] or self:getDefaultUnfoundFile()
		elseif quaImgType == kItemImgType.Pattern then
			return itemRectPath .. itemQuaPatternPath[qua] or self:getDefaultUnfoundFile()
		end
	end

	return self:getDefaultUnfoundFile()
end

local itemFile = "asset/items/"

function GameStyle:getItemFile(itemId)
	return itemFile .. itemId .. ".png" or self:getDefaultUnfoundFile()
end

local emblemBottomPath = {
	"pic_baise_di_pzk_sms.png",
	"pic_lvse_di_pzk_sms.png",
	"pic_lanse_di_pzk_sms.png",
	"pic_zise_di_pzk_sms.png",
	"pic_huangse_di_pzk_sms.png",
	"pic_hongse_di_pzk_sms.png"
}
local emblemQuaRectPath = {
	"pic_baise_pzk_sms.png",
	"pic_lvse_pzk_sms.png",
	"pic_lanse_pzk_sms.png",
	"pic_zise_pzk_sms.png",
	"pic_huangse_pzk_sms.png",
	"pic_hongse_pzk_sms.png"
}

function GameStyle:getEmblemBottomFile(qua)
	return "asset/heroRect/heroBottomRect/" .. emblemBottomPath[qua] or self:getDefaultUnfoundFile()
end

function GameStyle:getEmblemQuaRectFile(qua)
	return "asset/heroRect/heroQuaRect/" .. emblemQuaRectPath[qua] or self:getDefaultUnfoundFile()
end

function GameStyle:createEmptyIcon(isLock)
	local node = cc.Node:create()
	local lockPic = ccui.ImageView:create("asset/common/common_bg_kp_1.png")

	lockPic:addTo(node):posite(0, -37)

	local pic = ccui.ImageView:create("asset/common/common_bg_kp_2.png")

	pic:addTo(node)

	local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_R, 18)

	GameStyle:setCommonOutlineEffect(label)
	label:addTo(node)
	label:setName("TipText")
	label:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
	label:setOverflow(cc.LabelOverflow.SHRINK)
	label:setDimensions(100, 80)

	return node
end

function GameStyle:createAddImgEmptyIcon(isLock, style)
	style = style or {}

	local node = cc.Node:create()
	local lockPic = ccui.ImageView:create("asset/commonRaw/bg_kz_empty.png")

	lockPic:addTo(node):posite(2, -10)
	lockPic:setScale(0.7)

	local label = cc.Label:createWithTTF("", TTF_FONT_FZYH_R, 18)

	GameStyle:setCommonOutlineEffect(label)
	label:addTo(node)
	label:setName("TipText")
	label:setHorizontalAlignment(1)

	if style.showAddImg then
		local pic = ccui.ImageView:create("yinghun_common_plus.png", ccui.TextureResType.plistType)

		pic:addTo(node):posite(-1, -2)
	end

	return node
end

function GameStyle:setTabNormalTextEffect(text)
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(132, 167, 223, 255)
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text:enableOutline(cc.c4b(53, 55, 59, 255), 2)
	text:enableShadow(cc.c4b(6, 28, 54, 117.30000000000001), cc.size(2, 0), 2)
end

function GameStyle:setTabPressTextEffect(text)
	local lineGradiantVec2 = {
		{
			ratio = 0.3,
			color = cc.c4b(255, 255, 255, 255)
		},
		{
			ratio = 0.7,
			color = cc.c4b(255, 244, 120, 255)
		}
	}

	text:enablePattern(cc.LinearGradientPattern:create(lineGradiantVec2, {
		x = 0,
		y = -1
	}))
	text:enableOutline(cc.c4b(159, 52, 0, 127.5), 2)
end

local qualityTextColorMap = {
	[ColorType.kWhite] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 255, 254)
	},
	[ColorType.kGreen] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(189, 255, 85)
	},
	[ColorType.kBlue] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(79, 199, 254)
	},
	[ColorType.kPurple] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(215, 75, 254)
	},
	[ColorType.kOrange] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 159, 48)
	},
	[ColorType.kRed] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 76, 77)
	},
	[ColorType.kBlock] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 76, 77)
	}
}

function GameStyle:setQualityText(text, quaIndex, ignoreOutline)
	local data = qualityTextColorMap[tonumber(quaIndex)]

	if data then
		local outline = data.outline
		local color = data.color

		if not ignoreOutline then
			text:enableOutline(outline, 1)
		end

		text:setColor(color)
	end
end

local rarityTextColorMap = {
	[10] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 255, 255)
	},
	[11] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(189, 255, 85)
	},
	[12] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(79, 199, 254)
	},
	[13] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(215, 75, 254)
	},
	[14] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 159, 48)
	},
	[15] = {
		outline = cc.c4b(0, 0, 0, 219.29999999999998),
		color = cc.c3b(255, 76, 77)
	}
}

function GameStyle:setRarityText(text, rarity, ignoreOutline)
	local data = rarityTextColorMap[tonumber(rarity)]

	if not ignoreOutline then
		text:enableOutline(data.outline, 1)
	end

	text:setColor(data.color)
end

function GameStyle:getEquipRarityColor(rarity)
	local data = rarityTextColorMap[tonumber(rarity)]

	return data.color or rarityTextColorMap[11].color
end

function GameStyle:setGreenCommonEffect(text, notAddKerning)
	text:setTextColor(cc.c3b(223, 255, 46))
	text:enableOutline(cc.c4b(57, 75, 10, 255), 2)

	if not notAddKerning then
		text:setAdditionalKerning(8)
	end
end

function GameStyle:setGoldCommonEffect(text, notAddKerning)
	text:setTextColor(cc.c3b(255, 211, 128))
	text:enableOutline(cc.c4b(140, 70, 0, 255), 2)

	if not notAddKerning then
		text:setAdditionalKerning(8)
	end
end

function GameStyle:setCommonOutlineEffect(text, opacity, width)
	text:enableOutline(cc.c4b(0, 0, 0, opacity or 219.29999999999998), width or 1)
end

function GameStyle:runCostAnim(node)
	node:stopAllActions()

	local action1 = cc.CSLoader:createTimeline("asset/ui/CostNode.csb")

	node:runAction(action1)
	action1:clearFrameEventCallFunc()
	action1:gotoFrameAndPlay(0, 8, false)
end

function GameStyle:getClimateById(_id)
	if not _id then
		return
	end

	local id = tonumber(_id)

	if id == 0 then
		return ClimateType.Sunshine
	elseif id == 1 then
		return ClimateType.Cloudy
	elseif id == 2 then
		return ClimateType.Overcast
	elseif id == 18 or id == 45 then
		return ClimateType.Mist
	elseif id >= 3 and id <= 7 then
		return ClimateType.RainS
	elseif id >= 8 and id <= 10 then
		return ClimateType.Rain
	elseif id >= 13 and id <= 15 then
		return ClimateType.SnowS
	elseif id >= 16 and id <= 19 then
		return ClimateType.Snow
	else
		return ClimateType.Sunshine
	end
end

function GameStyle:setCostNodeEffect(node)
	node:getChildByFullName("costBg.costPanel.cost"):enableOutline(cc.c4b(20, 20, 20, 109.64999999999999), 2)
	node:getChildByFullName("costBg.costPanel.costLimit"):enableOutline(cc.c4b(20, 20, 20, 109.64999999999999), 2)
	node:getChildByFullName("costBg.cost"):enableOutline(cc.c4b(20, 20, 20, 109.64999999999999), 2)
end

function GameStyle:getStageBuffInfo(stageType)
	local defBuff = "Complete_BattleBuff"
	local _data = ConfigReader:getDataByNameIdAndKey("ConfigValue", defBuff, "content")
	local buffId = _data[stageType]

	if not buffId then
		return nil
	end

	local buffInfo = ConfigReader:getRecordById("SkillAttrEffect", buffId)
	local iconName, title, desc

	return {
		iconName = "asset/common/" .. buffInfo.Icon .. ".png",
		title = Strings:get(buffInfo.Name),
		desc = ConfigReader:getEffectDesc("SkillAttrEffect", buffInfo.EffectDesc, buffId),
		type = RewardType.kRewardLink
	}
end

local kBgAnimAndImage = {
	[GalleryPartyType.kBSNCT] = {
		"businiao_choukahuodeyinghun",
		"asset/scene/party_bg_businiao",
		"asset/ui/gallery/party_icon_businiao.png"
	},
	[GalleryPartyType.kXD] = {
		"xide_choukahuodeyinghun",
		"asset/scene/party_bg_xide",
		"asset/ui/gallery/party_icon_xide.png"
	},
	[GalleryPartyType.kMNJH] = {
		"monv_choukahuodeyinghun",
		"asset/scene/party_bg_monv",
		"asset/ui/gallery/party_icon_monv.png"
	},
	[GalleryPartyType.kDWH] = {
		"dongwenhui_choukahuodeyinghun",
		"asset/scene/party_bg_dongwenhui",
		"asset/ui/gallery/party_icon_dongwenhui.png"
	},
	[GalleryPartyType.kWNSXJ] = {
		"weinasi_weinasixianjing",
		"asset/scene/party_bg_weinasi",
		"asset/ui/gallery/party_icon_weinasi.png"
	},
	[GalleryPartyType.kSSZS] = {
		"shebeijing_choukahuodeyinghun",
		"asset/scene/party_bg_sszs",
		"asset/ui/gallery/party_icon_she.png"
	},
	[GalleryPartyType.kUNKNOWN] = {
		"unknown_choukahuodeyinghun",
		"asset/scene/party_bg_unknown",
		"asset/ui/gallery/party_icon_unknown.png"
	}
}

function GameStyle:getHeroPartyBgData(party)
	party = party or GalleryPartyType.kBSNCT

	return kBgAnimAndImage[party]
end

function GameStyle:getHeroPartyBg(party)
	local partyData = self:getHeroPartyBgData(party)
	local bgAnim = cc.MovieClip:create(partyData[1])
	local bg1 = bgAnim:getChildByFullName("bg1")
	local bg2 = bgAnim:getChildByFullName("bg2")
	local bg3 = bgAnim:getChildByFullName("bg3")

	if bg1 then
		local bgImage = ccui.ImageView:create(partyData[2] .. ".jpg")

		bgImage:addTo(bg1)

		if bg2 and bg3 then
			local bgImage = ccui.ImageView:create(partyData[2] .. "mohu.jpg")

			bgImage:addTo(bg2)

			local bgImage = ccui.ImageView:create(partyData[2] .. "mohu.jpg")

			bgImage:addTo(bg3)
		end
	end

	return bgAnim
end

function GameStyle:getHeroAwakenBg(heroInfo)
	local path = "asset/scene/" .. heroInfo:getAwakenStarConfig().Since .. ".jpg"

	return ccui.ImageView:create(path)
end

function GameStyle:getHeroPartyByHeroInfo(heroInfo)
	if heroInfo and heroInfo:getAwakenStar() > 0 then
		return self:getHeroAwakenBg(heroInfo)
	end

	return self:getHeroPartyBg(heroInfo:getParty())
end

kLockImage = {
	"asset/common/common_icon_lock_new.png",
	"asset/common/common_icon_unlock_new.png"
}
composePosImage = {
	Weapon = "shengming_wuqi_hui.png",
	Tops = "shengming_zhuangbei_hui.png",
	Decoration = "shengming_shipin_hui.png",
	Shoes = "shengming_xie_hui.png"
}
composePosImage_icon = {
	Weapon = {
		"icon_shengming_hui.png",
		"icon_shengming.png"
	},
	Shoes = {
		"icon_shengming_hui3.png",
		"icon_shengming3.png"
	},
	Tops = {
		"icon_shengming_hui2.png",
		"icon_shengming2.png"
	},
	Decoration = {
		"icon_shengming_hui4.png",
		"icon_shengming4.png"
	}
}

local leadStageColor = {
	cc.c3b(153, 152, 179),
	cc.c3b(68, 172, 68),
	cc.c3b(236, 162, 28),
	cc.c3b(56, 136, 247),
	cc.c3b(193, 86, 217),
	cc.c3b(228, 117, 67),
	cc.c3b(229, 86, 105),
	(cc.c3b(49, 40, 171))
}

function GameStyle:getLeadStageColor(lv)
	return leadStageColor[lv]
end

local TsoulPosImg = {
	itemFile .. "timesoul_ico_zuo.png",
	itemFile .. "timesoul_ico_zhong.png",
	itemFile .. "timesoul_ico_you.png"
}

function GameStyle:getTSoulPosImage(pos)
	return TsoulPosImg[tonumber(pos)] or TsoulPosImg[1]
end

WeekStringId = {
	"ClubMapBoss_OpenTime_Day1",
	"ClubMapBoss_OpenTime_Day2",
	"ClubMapBoss_OpenTime_Day3",
	"ClubMapBoss_OpenTime_Day4",
	"ClubMapBoss_OpenTime_Day5",
	"ClubMapBoss_OpenTime_Day6",
	"ClubMapBoss_OpenTime_Day7"
}

function GameStyle:getWeekStr(week)
	return Strings:get(WeekStringId[week])
end

function GameStyle:setDarken(node, stage)
	if node then
		if stage then
			node:setColor(cc.c3b(115, 115, 115))
		else
			node:setColor(cc.c3b(255, 255, 255))
		end
	end
end

function GameStyle:getTitleStr(titleId)
	local config = ConfigReader:getRecordById("PlayerTitle", titleId)

	if config then
		return "[" .. Strings:get(config.Name) .. "]", config.Color
	end

	return "", ""
end
