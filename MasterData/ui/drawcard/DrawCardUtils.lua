-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\DrawCard\\DrawCardUtils.lua

local ResDrawPoolClient = require("ClientData/ResDrawPoolClient")
local ResDrawFakeRand = require("ClientData/ResDrawFakeRand")
local ConsumeTips = require("System/ConsumeTips")
local UserData = require("Helper/UserData")
local Analytics = require("SDK/Analytics")
local ResDrawMisc = require("ClientData/ResDrawMisc")
local DrawCardUtils = {}

function DrawCardUtils.realDrawCard(drawType, drawCount, drawCost, needItemId, needItemNum, poolId, group)
	if drawType == Const.DrawTypeFree then
		return
	end

	if drawCost ~= Const.DrawCostTypeNone and not DrawCardUtils.checkRemainCount(drawType, drawCount) then
		CurAvatar:dayDrawTryHideOptDlg()
		MsgManager.notice(Lang.get(30265))

		return
	end

	if drawType == Const.DrawTypeGroup and not DrawCardUtils.groupValid(group) then
		MsgManager.notice(Lang.get(30266))

		return
	end

	local nowTotalDraw = 0

	if drawType == Const.DrawTypeNewbie then
		if CurAvatar.roleDrawData and CurAvatar.roleDrawData[drawType] and CurAvatar.roleDrawData[drawType].drawCount then
			nowTotalDraw = CurAvatar.roleDrawData[drawType].drawCount * 10
		end

		CurAvatar:manualDecNewbieCount()
	else
		CurAvatar:setDrawCache(drawCount, needItemId, needItemNum, poolId, group)

		if CurAvatar.roleDrawData and CurAvatar.roleDrawData[drawType] then
			nowTotalDraw = CurAvatar.roleDrawData[drawType].totalDrawCount
		end
	end

	CurAvatar:battleMiscReq(3)
	ConsumeTips.showTipsDrawCrad(drawCount, drawCost, needItemId, Functor(DrawCardUtils.doDraw, drawType, drawCount, drawCost, group, nowTotalDraw), nil, drawType)
end

function DrawCardUtils.doDraw(drawType, drawCount, drawCost, group, nowTotalDraw)
	RPC.draw(drawType, drawCount, drawCost, group, nowTotalDraw)

	if RegionUtils.isKR() and drawType == Const.DrawTypeStandard and drawCount == 10 then
		DrawCardUtils.doOpActDrawCountKR()
	elseif RegionUtils.isSEA() and drawCount == 10 then
		DrawCardUtils.doOpActDrawCountSEA()
	end
end

function DrawCardUtils.realDrawOpActCard(actId, drawCount, drawCost, needItemId, needItemNum, poolId, group)
	local actObj = CurAvatar:getActivityObj(actId)

	if not actObj or not actObj.actData then
		return
	end

	if drawCost ~= Const.DrawCostTypeNone and not DrawCardUtils.checkRemainCount(actObj.opId, drawCount) then
		CurAvatar:dayDrawTryHideOptDlg()
		MsgManager.notice(Lang.get(30265))

		return
	end

	CurAvatar:setDrawCache(drawCount, needItemId, needItemNum, poolId, group, actId)
	CurAvatar:battleMiscReq(3)

	if actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_UP then
		local careerId = actObj.actData:getCareerIdByPoolId(poolId)
		local alreadyDrawCount = actObj.actData.careerDrawData[careerId].totalDrawCount or 0

		ConsumeTips.showTipsDrawCrad(drawCount, drawCost, needItemId, Functor(DrawCardUtils.doOpActNewbieUpDraw, actObj.opId, drawCount, drawCost, alreadyDrawCount, careerId))
	elseif actObj.actType == Const.ACT_TYPE_DRAW_NEWBIE_CAMP then
		local alreadyDrawCount = actObj.actData.serverData.totalDrawCount or 0

		ConsumeTips.showTipsDrawCrad(drawCount, drawCost, needItemId, Functor(DrawCardUtils.doOpActNewbieCampDraw, actObj.opId, drawCount, drawCost, alreadyDrawCount))
	elseif actObj.actType == Const.ACT_TYPE_SEASON_DRAW then
		local alreadyDrawCount = actObj.actData.count or 0

		ConsumeTips.showTipsDrawCrad(drawCount, drawCost, needItemId, Functor(DrawCardUtils.doSeasonPlayDraw, actObj.opId, drawCount, drawCost, alreadyDrawCount))
	else
		local alreadyDrawCount = actObj.actData.serverData.totalDrawCount or 0

		ConsumeTips.showTipsDrawCrad(drawCount, drawCost, needItemId, Functor(DrawCardUtils.doOpActDraw, actObj.opId, drawCount, drawCost, alreadyDrawCount))
	end
end

function DrawCardUtils.doOpActDraw(opId, drawCount, drawCost, alreadyDrawCount)
	RPC.opActDraw(opId, drawCount, drawCost, alreadyDrawCount)

	if RegionUtils.isKR() and drawCount == 10 then
		DrawCardUtils.doOpActDrawCountKR()
	end
end

function DrawCardUtils.doOpActNewbieUpDraw(opId, drawCount, drawCost, alreadyDrawCount, careerId)
	RPC.opActDrawNewbieUpDraw(opId, careerId, drawCount, drawCost, alreadyDrawCount)
end

function DrawCardUtils.doOpActNewbieCampDraw(opId, drawCount, drawCost, alreadyDrawCount)
	RPC.opActDrawNewbieCampDraw(opId, drawCount, drawCost, alreadyDrawCount)
end

function DrawCardUtils.doSeasonPlayDraw(opId, drawCount, drawCost, alreadyDrawCount)
	RPC.opActDrawSeasonDraw(opId, drawCount, drawCost, alreadyDrawCount)
end

function DrawCardUtils.checkOpActCanDraw(actId)
	local actObj = CurAvatar:getActivityObj(actId)

	if not actObj or not actObj.actData then
		return false
	end

	if not actObj:isValid() or actObj:inFreeze() then
		MsgManager.notice(Lang.get(1870))

		return false
	end

	return true
end

local function _clearUIWhenJump()
	local drawResultDlg = UIManager.getUI("drawCardResultDlg", nil, false)

	if drawResultDlg then
		drawResultDlg:setVisible(false)
	end

	local drawOptDlg = UIManager.getUI("drawCardOperateDlg", nil, false)

	if drawOptDlg then
		drawOptDlg:setVisible(false)
	end

	local drawResultLightDlg = UIManager.getUI("drawCardResultLightDlg", nil, false)

	if drawResultLightDlg then
		drawResultLightDlg:setVisible(false)
	end

	local drawOptLightDlg = UIManager.getUI("drawCardOptLightDlg", nil, false)

	if drawOptLightDlg then
		drawOptLightDlg:setVisible(false)
	end

	local drawNewbieConfirmDlg = UIManager.getUI("drawNewbieConfirmDlg", nil, false)

	if drawNewbieConfirmDlg then
		drawNewbieConfirmDlg:setVisible(false)
	end
end

local function _clearUIWhenAddBag()
	local drawNewbieConfirmDlg = UIManager.getUI("drawNewbieConfirmDlg", nil, false)

	if drawNewbieConfirmDlg then
		drawNewbieConfirmDlg:setVisible(false)
	end
end

function DrawCardUtils.checkBag(needCount)
	local remainNum = CurAvatar:getHeroRemainBlankNum()

	if needCount <= remainNum then
		return true
	else
		CurAvatar:confirmBagAdd(Const.BAG_TYPE_HERO, _clearUIWhenAddBag, _clearUIWhenJump, _clearUIWhenJump)

		return false
	end
end

function DrawCardUtils.checkRemainCount(drawType, drawCount)
	if CurAvatar:dayDrawCountLimitOpen() then
		local drawDayCount = CurAvatar:getDrawDayCount(drawType, Const.DayDrawMaxCountFree)
		local remainCount = math.max(0, Const.DayDrawMaxCountFree - drawDayCount)

		return remainCount > 0 and drawCount <= remainCount
	else
		return true
	end
end

function DrawCardUtils.getPoolClientInfo(poolId)
	local poolClientInfo = ResDrawPoolClient[poolId]

	if not poolClientInfo then
		return
	end

	return poolClientInfo
end

function DrawCardUtils.getPoolFakeRandInfo(poolId)
	local poolFakeRandInfo = ResDrawFakeRand[poolId]

	if not poolFakeRandInfo then
		return
	end

	return poolFakeRandInfo
end

function DrawCardUtils.syncDrawRecord(poolId, opId, param)
	local seq = 0

	if poolId and CurAvatar and CurAvatar.poolSeqDict and CurAvatar.poolSeqDict[poolId] then
		seq = CurAvatar.poolSeqDict[poolId]
	elseif opId and CurAvatar and CurAvatar.opActSeqDict and CurAvatar.opActSeqDict[opId] then
		seq = CurAvatar.opActSeqDict[opId]
	end

	RPC.drawRecord(poolId, opId, seq, param)
end

function DrawCardUtils.getDrawRecord(poolId, opId)
	if poolId and CurAvatar and CurAvatar.poolRecordDict and CurAvatar.poolRecordDict[poolId] then
		return CurAvatar.poolRecordDict[poolId]
	elseif opId and CurAvatar and CurAvatar.opActRecordDict and CurAvatar.opActRecordDict[opId] then
		return CurAvatar.opActRecordDict[opId]
	end

	return {}
end

function DrawCardUtils.checkDrawCost(poolId, drawCount, skipNotice)
	return CurAvatar:checkDrawItem(poolId, drawCount, skipNotice)
end

function DrawCardUtils.isNextProbiliatyUp(items)
	local hasHigh = false

	for _, hero in ipairs(items) do
		if hero.star >= 5 then
			hasHigh = true

			break
		end
	end

	return not hasHigh
end

function DrawCardUtils.probilityUpText()
	return Lang.get(30267)
end

function DrawCardUtils.calcDisconnectTex(totalCost, singleCost)
	if Const.SHOP_DISCOUNT_MODE then
		return "10"
	else
		return "9"
	end
end

function DrawCardUtils.calcFreeDrawCount(needItemId, needItemNum)
	local curItemNum = CurAvatar:getItemNumById(needItemId)
	local totalDrawCount = math.floor(curItemNum / needItemNum)

	if totalDrawCount <= 0 then
		return 0
	else
		totalDrawCount = math.min(totalDrawCount, 10)

		return totalDrawCount
	end
end

local MAX_NEWBIE_COUNT = 20
local NEWBIE_REMAIN_COUNT = 5

function DrawCardUtils.getNewbieMaxCount()
	return MAX_NEWBIE_COUNT
end

function DrawCardUtils.getNewbieRemainCount(...)
	return NEWBIE_REMAIN_COUNT
end

function DrawCardUtils.newbieDrawCountIs(targetNum)
	local drawData = CurAvatar.roleDrawData[Const.DrawTypeNewbie]

	if not drawData then
		return false
	end

	return drawData.drawCount == targetNum
end

function DrawCardUtils.hasNewbieCount()
	local drawData = CurAvatar.roleDrawData[Const.DrawTypeNewbie]

	if not drawData then
		return false
	end

	local chooseFlag = drawData.chooseFlag

	if chooseFlag == 1 then
		return false
	else
		local drawCount = drawData.drawCount

		return drawCount < MAX_NEWBIE_COUNT
	end
end

function DrawCardUtils.getNewbieLeftCount()
	local drawData = CurAvatar.roleDrawData[Const.DrawTypeNewbie]

	if not drawData then
		return 0
	end

	return MAX_NEWBIE_COUNT - drawData.drawCount
end

function DrawCardUtils.getNewbieLeftResetCount()
	local totalCount = ResDrawMisc[1].newbie_reset_count or 0
	local drawData = CurAvatar.roleDrawData[Const.DrawTypeNewbie]
	local useCount = drawData and drawData.resetCount or 0

	return totalCount - useCount
end

function DrawCardUtils.getDrawRecords()
	local drawData = CurAvatar.roleDrawData[Const.DrawTypeNewbie]

	if not drawData then
		return
	end

	return drawData.records
end

function DrawCardUtils.getOrangeOnlyFlag()
	return CurAvatar.newbieShowOrangeOnly or false
end

function DrawCardUtils.setOrangeOnlyFlag(flag)
	CurAvatar.newbieShowOrangeOnly = flag
end

function DrawCardUtils.getHeroQualitys(heroList)
	local orange = 0
	local purple = 0
	local blue = 0
	local orangeHeroIdList = {}

	for _, itemInfo in ipairs(heroList) do
		local quality = UIConst.getHeroQuality(itemInfo.id)

		if quality >= Const.HERO_QUALITY_S then
			orange = orange + 1

			table.insert(orangeHeroIdList, itemInfo.id)
		elseif quality == Const.HERO_QUALITY_A then
			purple = purple + 1
		else
			blue = blue + 1
		end
	end

	return orange, purple, blue, orangeHeroIdList
end

function DrawCardUtils.getAllOrangeHeros()
	local orangeDict = {}

	for k, hero in pairs(CurAvatar.heroDic) do
		if hero.quality >= Const.HERO_QUALITY_S then
			orangeDict[hero.id] = true
		end
	end

	local orangeList = {}

	for k, v in pairs(orangeDict) do
		table.insert(orangeList, k)
	end

	return orangeList
end

function DrawCardUtils.setNewbieRetrieve()
	CurAvatar.drawNewbieRetrieve = true
end

function DrawCardUtils.isNewabieResultRetrieve()
	return CurAvatar.drawNewbieRetrieve
end

function DrawCardUtils.groupValid(group)
	if group ~= CurAvatar.todayDrawGroup and not CurAvatar:isAllGroupUnlock() and not DrawCardUtils.groupHasReplaced(group) then
		return false
	end

	return true
end

function DrawCardUtils.groupHasReplaced(group)
	if group == Const.DrawCampLightDark then
		return CurAvatar:poolHasReplaced(Const.DrawPoolIdLightDark)
	else
		return CurAvatar:poolHasReplaced(Const.DrawPoolIdCamp)
	end
end

function DrawCardUtils.getGroupDispInfo(group)
	local atlasPath = "Atlas/HeroAtlas/HeroCardCommonAtlas"
	local spriteName = "IconGroup0" .. group
	local nameAtlasPath = "Atlas/HeroPoolAtlas/HeroPoolAtlas"
	local nameSpriteName = "TextGroup0" .. group

	return atlasPath, spriteName, nameAtlasPath, nameSpriteName
end

DrawCardUtils.SMALL_GROUP_ICON = {
	[Const.CAMP_TYPE.CLASS] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"IconGroupRed"
	},
	[Const.CAMP_TYPE.POPULAR] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"IconGroupYellow"
	},
	[Const.CAMP_TYPE.LEGEND] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"IconGroupBlue"
	},
	[Const.DrawCampLightDark] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"IconGroupLightBlack"
	}
}
DrawCardUtils.GROUP_BG = {
	[Const.CAMP_TYPE.CLASS] = "NoAlpha/HeroPool/BgHeroPoolLETSREDBack",
	[Const.CAMP_TYPE.POPULAR] = "NoAlpha/HeroPool/BgHeroPoolTenmaBack",
	[Const.CAMP_TYPE.LEGEND] = "NoAlpha/HeroPool/BgHeroPoolGalateaBack",
	[Const.DrawCampLightDark] = "NoAlpha/HeroPool/BgHeroPoolLBBack"
}
DrawCardUtils.GROUP_SELECT_IMG = {
	[Const.CAMP_TYPE.CLASS] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgLetsRedSel"
	},
	[Const.CAMP_TYPE.POPULAR] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgBoxBackSel"
	},
	[Const.CAMP_TYPE.LEGEND] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgGalateaSel"
	},
	[Const.DrawCampLightDark] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgBoxBackSel"
	}
}
DrawCardUtils.GROUP_BUY_IMG = {
	[Const.CAMP_TYPE.CLASS] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BtnLetsredBuy"
	},
	[Const.CAMP_TYPE.POPULAR] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BtnBuy"
	},
	[Const.CAMP_TYPE.LEGEND] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BtnGalateaBuy"
	},
	[Const.DrawCampLightDark] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BtnBuy"
	}
}
DrawCardUtils.GROUP_ONE_BOX_IMG = {
	[Const.CAMP_TYPE.CLASS] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgOneBox1"
	},
	[Const.CAMP_TYPE.POPULAR] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgOneBox2"
	},
	[Const.CAMP_TYPE.LEGEND] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgOneBox3"
	},
	[Const.DrawCampLightDark] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgOneBox4"
	}
}
DrawCardUtils.GROUP_TEN_BOX_IMG = {
	[Const.CAMP_TYPE.CLASS] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgTenBox1"
	},
	[Const.CAMP_TYPE.POPULAR] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgTenBox2"
	},
	[Const.CAMP_TYPE.LEGEND] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgTenBox3"
	},
	[Const.DrawCampLightDark] = {
		"Atlas/HeroPoolAtlas/HeroPoolAtlas",
		"BgTenBox4"
	}
}

function DrawCardUtils.doOpActDrawCountKR()
	local opActDrawCountKR = UserData.loadCommonData("opActDrawCountKR")
	local index = 0

	if opActDrawCountKR ~= nil and opActDrawCountKR ~= "" then
		index = tonumber(opActDrawCountKR)
	end

	index = index + 1

	UserData.saveCommonData("opActDrawCountKR", index)

	if index == 5 then
		SDKAgent.reportBuriedPoint("af_SUMMON10_5", "Fire_SUMMON10_5")
	elseif index == 10 then
		SDKAgent.reportBuriedPoint("af_SUMMON10_10", "Fire_SUMMON10_10")
	elseif index == 20 then
		SDKAgent.reportBuriedPoint("af_SUMMON10_20", "Fire_SUMMON10_20")
	end
end

function DrawCardUtils.doOpActDrawCountSEA()
	local opActDrawCountSEA = UserData.loadCommonData("opActDrawCountSEA")

	if opActDrawCountSEA ~= "reported" then
		UserData.saveCommonData("opActDrawCountSEA", "reported")

		local data = Analytics.getBiliSeaSendLogPubParameter()

		data.af_content = "DrawCard_1-12"

		ChannelUtil.doAnyFunction("appsflyerTrackEventKey", {
			eventName = "af_first_gacha_10",
			eventValue = ClientUtils.table2String(data)
		})
		ChannelUtil.doAnyFunction("firebaseTrackEventKey", {
			eventName = "G_first_gacha_10",
			eventValue = ClientUtils.table2String(data)
		})
	end
end

return DrawCardUtils
