-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaChooseDifficultyView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaChooseDifficultyView", package.seeall)

local MiyaChooseDifficultyView = class("MiyaChooseDifficultyView", ViewComponent)

function MiyaChooseDifficultyView:unbindEvents()
	MiyaChooseDifficultyView.super.unbindEvents(self)
end

function MiyaChooseDifficultyView:bindEvents()
	MiyaChooseDifficultyView.super.bindEvents(self)
end

function MiyaChooseDifficultyView:onExit()
	MiyaChooseDifficultyView.super.onExit(self)

	for _, v in ipairs(self._imgIcons) do
		MaterialMgr:clearIcon(v)
	end

	self._imgIcons = nil
end

function MiyaChooseDifficultyView:buildUI()
	MiyaChooseDifficultyView.super.buildUI(self)

	self._txtDesc = MaterialMgr.findGraphicText(self.mainGO, "bubble/txtDesc")
	self._difficultys = self:getGo("difficultys")
end

function MiyaChooseDifficultyView:onEnter()
	MiyaChooseDifficultyView.super.onEnter(self)
	self:_updateDesc()

	self._imgIcons = {}

	local cfgs = MiyaGameConfig.instance:getDifficultyCfgs()

	GameUtil.updateCells(self._difficultys, cfgs, self._updateOneDifficulty, self)
end

function MiyaChooseDifficultyView:_updateDesc()
	local matType, matId, matNum = 8, 1, 1000
	local matCfg = MaterialMgr.getMatCfg(matType, matId)
	local matStr = TipsFacade.instance:getContentMatStr(string.format("%s:%s", matType, matId), 40, -10, true)

	self._txtDesc.text = string.format("投入%s%s，与我进行对弈。\n投入越多，难度越大，但奖励更丰厚。", matCfg.name, matStr)
end

function MiyaChooseDifficultyView:_updateOneDifficulty(cell, cfg)
	local btnStart = Framework.ButtonAdapter.GetFrom(cell, "btnStart")
	local imgPowerNum = goutil.findChildComponent(cell, "power/imgNum", typeof(UIImgNumeralText))
	local imgCost = goutil.findChild(cell, "put/item")
	local txtCostNum = goutil.findChildTextComponent(cell, "put/txtCount")
	local imgPrize = goutil.findChild(cell, "reward/item")
	local txtPrizeNum = goutil.findChildTextComponent(cell, "reward/txtCount")

	self:_updateMat(imgCost, txtCostNum, cfg.costMaterial)
	self:_updateMat(imgPrize, txtPrizeNum, cfg.passPrize)
	imgPowerNum:SetText(MiyaGameController.instance:getRecommendZdl(cfg.difficulty))
	btnStart:AddClickListener(function()
		self:_onClickStart(cfg)
	end)
end

function MiyaChooseDifficultyView:_updateMat(uiImage, uiText, matStr)
	local matType, matId, matNum = unpack(string.splitToNumber(matStr, ":"))

	MaterialMgr.setIcon(uiImage, matType, matId)

	uiText.text = "x" .. matNum

	table.insert(self._imgIcons, uiImage)
end

function MiyaChooseDifficultyView:_onClickStart(cfg, costMat)
	local matType, matId, matNum = unpack(string.splitToNumber(cfg.costMaterial, ":"))
	local title = cfg.difficultyName .. "难度"
	local challengeId = MiyaGameModel.instance:getChallengeId()
	local graphicStr = TipsFacade.instance:getContentMatStr(string.format("%s:%s", matType, matId), 40, -10, true)
	local text = langPara("timed_challenge_choose_difficulty_tip", matNum, graphicStr, cfg.difficultyName)

	TLChallengeController.instance:openTLCTip(title, text, nil, function()
		MiyaGameController.instance:randomModeReq(cfg.difficulty, self._onRandomRes, self)
	end, nil, challengeId, true)
end

function MiyaChooseDifficultyView:_onRandomRes(msg)
	self:close()
	GlobalDispatcher:dispatch(GlobalNotify.MiyaReOpenDetailView)
end

return MiyaChooseDifficultyView
