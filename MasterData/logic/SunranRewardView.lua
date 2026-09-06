-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunranbattle/view/SunranRewardView.lua

module("logic.extensions.sunranbattle.view.SunranRewardView", package.seeall)

local SunranRewardView = class("SunranRewardView", TableViewComponent)

function SunranRewardView:ctor()
	SunranRewardView.super.ctor(self)
end

function SunranRewardView:bindEvents()
	SunranRewardView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function SunranRewardView:unbindEvents()
	SunranRewardView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function SunranRewardView:onExit()
	return
end

function SunranRewardView:destroyUI()
	SunranRewardView.super.destroyUI(self)

	local iigBig = self._iconImaGo.gameObject:GetComponent("ImageBigBG")

	if iigBig then
		iigBig:ClearImage()
	end
end

function SunranRewardView:buildUI()
	SunranRewardView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")

	local scoreInfoGo = self:getGo("scoreInfoGo")

	self._iconImaGo = goutil.findChild(scoreInfoGo, "iconIma")
	self._scoreTxt = goutil.findChildTextComponent(scoreInfoGo, "scoreTxt")
end

function SunranRewardView:onEnter()
	SunranRewardView.super.onEnter(self)

	local openCfg = SunranBattleConfig.instance:getOpenTimeCfg()

	if openCfg == nil then
		printError("sr---挑战 SunranRewardView:onEnter()   获取的开启时间为空")

		return
	end

	uGuiUtil.setSpriteToImage(self._iconImaGo, uGuiUtil.SpriteType.BigBg, GameUrl.getItemIconUrl(openCfg.scoreIcon))

	local count = self:getFirstParam()

	self._scoreTxt.text = tostring(count)
	self._curViewDatas = SunranBattleModel.instance:getAllScorePrizeCfg(openCfg.seasonId, count)

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		printError("sr---挑战 SunranRewardView:onEnter()   获取赛季积分奖励配置为空！！")

		return
	end

	self._tableview:ReloadData()
end

function SunranRewardView:_getPath()
	return {
		cellPath = "scoreItem",
		viewPath = "scoreListSR"
	}
end

function SunranRewardView:_cellSize()
	return 882, 80
end

function SunranRewardView:_updateCell(view, cell, data)
	local rewardPosGo = goutil.findChild(cell, "rewardPosGo")
	local rewardPosList = {
		goutil.findChild(rewardPosGo, "reward_1"),
		goutil.findChild(rewardPosGo, "reward_2"),
		goutil.findChild(rewardPosGo, "reward_3"),
		goutil.findChild(rewardPosGo, "reward_4"),
		goutil.findChild(rewardPosGo, "reward_5"),
		goutil.findChild(rewardPosGo, "reward_6")
	}
	local itemFinshGo = goutil.findChild(cell, "itemFinshGo")
	local itemStateGo = goutil.findChild(cell, "itemStateGo")
	local itemDescTxt = goutil.findChildTextComponent(cell, "itemDescTxt")
	local itemScoreTxt = goutil.findChildTextComponent(cell, "itemScoreTxt")

	for i = 1, #rewardPosList do
		if rewardPosList[i] then
			MaterialMgr.resetAll(rewardPosList[i])
		end
	end

	if data.isFinish then
		itemStateGo:SetActive(false)
		itemFinshGo:SetActive(true)
	else
		itemFinshGo:SetActive(false)
		itemStateGo:SetActive(true)
	end

	itemScoreTxt.text = tostring(data.score)

	if data.matList then
		if not #data.matList then
			local count = 0
			local allCount = #rewardPosList

			if count == 0 then
				return
			end

			if allCount < count then
				count = allCount
			end

			local pos = 187.5 - 37.5 * (count - 1)

			for i = 1, count do
				if data.matList[i] and rewardPosList[i] then
					MaterialMgr.setCellByCfg(data.matList[i], rewardPosList[i])
					Framework.TransformUtil.SetLocalPos(rewardPosList[i].transform, pos + (i - 1) * 75, 0, 0)
				end
			end
		end
	end
end

return SunranRewardView
