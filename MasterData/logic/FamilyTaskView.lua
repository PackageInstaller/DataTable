-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/FamilyTaskView.lua

module("logic.extensions.newfamily.view.FamilyTaskView", package.seeall)

local FamilyTaskView = class("FamilyTaskView", TableViewComponent)

function FamilyTaskView:ctor()
	FamilyTaskView.super.ctor(self)

	self._matsStr = "8:27"
	self._curViewDatas = nil
end

function FamilyTaskView:bindEvents()
	FamilyTaskView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "familytask")
	end, self)
	self._daibiBtn:AddClickListener(function()
		MaterialMgr.openGetSourceByStr(self._matsStr)
	end, self)
end

function FamilyTaskView:unbindEvents()
	FamilyTaskView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._daibiBtn:RemoveClickListener()
end

function FamilyTaskView:onExit()
	FamilyTaskView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataNewFamilyTask, self._updataViewTaskShow, self)
end

function FamilyTaskView:destroyUI()
	FamilyTaskView.super.destroyUI(self)
	uGuiUtil.clearImage(self._iconImaGo)
	uGuiUtil.clearImage(self._daibiImaGo)

	self._curViewDatas = nil
end

function FamilyTaskView:buildUI()
	FamilyTaskView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")
	self._daibiBtn = self:getBtn("daibiItem")
	self._daibiImaGo = self:getGo("daibiItem/daibiIma")
	self._daibiTxt = self:getGo("daibiItem/daibiTxt"):GetComponent("Text")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._iconImaGo = goutil.findChild(leftInfoGo, "iconImaGo")
	self._taskProgSli = self:getSlider("leftInfoGo/taskProgSli")
	self._levelTxt = goutil.findChildTextComponent(leftInfoGo, "levelTxt")
	self._progTxt = goutil.findChildTextComponent(leftInfoGo, "progTxt")
	self._timeTxt = goutil.findChildTextComponent(leftInfoGo, "timeTxt")
	self._descTxt = goutil.findChildTextComponent(leftInfoGo, "descTxt")
	self._daibiTxt.text = ""
	self._levelTxt.text = ""
	self._progTxt.text = ""
	self._timeTxt.text = ""
	self._timeTxt.text = ""
	self._descTxt.text = ""

	self._taskProgSli:SetValue(0)
end

function FamilyTaskView:onEnter()
	FamilyTaskView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataNewFamilyTask, self._updataViewTaskShow, self)
	self:_updataViewTaskShow()
	MaterialMgr.updateItemByStr(self._daibiImaGo, self._matsStr)
	FamilyHonorController.instance:csRequestFamilyTaskInfoReq()
end

function FamilyTaskView:_updataViewTaskShow()
	local have = MaterialMgr.getMatCount(self._matsStr)

	self._timeTxt.text = "重置时间为每周周五5：00"
	self._daibiTxt.text = tostring(have)
	self._taskInfos = FamilyHonorModel.instance:getFamilyTaskInfo()

	local level, maxLevel = FamilyHonorModel.instance:getFamilyTaskLevelByScore(self._taskInfos.score)
	local levelCfg = FamilyHonorConfig.instance:getFamilyTaskLevelCfg(level)

	uGuiUtil.setSpriteToImage(self._iconImaGo, uGuiUtil.SpriteType.BigBg, "ui/bigbg/familycallorder/" .. levelCfg.icon .. ".png")

	local maxLevelCfg = FamilyHonorConfig.instance:getFamilyTaskLevelCfg(maxLevel)
	local nextLevelCfg = FamilyHonorConfig.instance:getFamilyTaskLevelCfg(level + 1)

	if nextLevelCfg == nil or maxLevelCfg and maxLevelCfg.startScore <= self._taskInfos.score then
		self._progTxt.text = ""

		self._taskProgSli:SetValue(1)

		self._levelTxt.text = "MAX"
	else
		local have = self._taskInfos.score - levelCfg.startScore
		local need = nextLevelCfg.startScore - levelCfg.startScore

		self._progTxt.text = have .. "/" .. need

		self._taskProgSli:SetValue(have / need)

		self._levelTxt.text = "LV." .. level
	end

	self._descTxt.text = levelCfg.addDesc
	self._curViewDatas = FamilyHonorModel.instance:getFamilyTaskCfgList()

	self._tableview:ReloadData()
end

function FamilyTaskView:_getPath()
	return {
		cellPath = "rightScrollGo/taskItem",
		viewPath = "rightScrollGo/taskItemSR"
	}
end

function FamilyTaskView:_cellSize()
	return 768, 114
end

function FamilyTaskView:_updateCell(view, cell, data)
	local jumpBtnGo = goutil.findChild(cell, "jumpBtn")
	local receiveBtnGo = goutil.findChild(cell, "receiveBtn")
	local goodsList = {
		goutil.findChild(cell, "goodsPos_1"),
		goutil.findChild(cell, "goodsPos_2"),
		goutil.findChild(cell, "goodsPos_3"),
		goutil.findChild(cell, "goodsPos_4")
	}
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local progerTxt = goutil.findChildTextComponent(cell, "progerTxt")
	local finishGo = goutil.findChild(cell, "finishGo")

	for _, go in pairs(goodsList) do
		MaterialMgr.resetAll(go)
	end

	GameUtil.asBtn(jumpBtnGo):RemoveClickListener()
	GameUtil.asBtn(receiveBtnGo):RemoveClickListener()

	nameTxt.text = data.cfg.title
	descTxt.text = data.cfg.desc

	local list = string.split(data.cfg.prizeClient, "#")

	if list and #list > 0 then
		for i = 1, #list do
			if list[i] and goodsList[i] then
				MaterialMgr.setCellByCfg(list[i], goodsList[i])
			end
		end
	end

	if data.stage == 1 then
		progerTxt.text = ""

		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(jumpBtnGo, false)
		GameUtil.SetActive(receiveBtnGo, true)
		GameUtil.asBtn(receiveBtnGo):AddClickListener(function()
			self:_onClickReceive(data)
		end, self)
	elseif data.stage == 3 then
		progerTxt.text = ""

		GameUtil.SetActive(jumpBtnGo, false)
		GameUtil.SetActive(receiveBtnGo, false)
		GameUtil.SetActive(finishGo, true)
	else
		progerTxt.text = data.progress .. "/" .. data.cfg.maxProgress

		GameUtil.SetActive(receiveBtnGo, false)
		GameUtil.SetActive(finishGo, false)
		GameUtil.SetActive(jumpBtnGo, true)
		GameUtil.asBtn(jumpBtnGo):AddClickListener(function()
			if not string.nilorempty(data.cfg.jumpTo) then
				GotoMgr.gotoByString(data.cfg.jumpTo)
			end
		end, self)
	end
end

function FamilyTaskView:_onClickReceive(data)
	local list = FamilyHonorModel.instance:getAllFinishTaskId()

	if #list > 0 then
		FamilyHonorController.instance:csRequestFamilyTaskGainPrizeReq(list)
	end
end

return FamilyTaskView
