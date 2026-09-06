-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarReplaceView.lua

module("logic.extensions.newfamily.view.war.FamilyWarReplaceView", package.seeall)

local FamilyWarReplaceView = class("FamilyWarReplaceView", TableViewComponent)

function FamilyWarReplaceView:ctor()
	FamilyWarReplaceView.super.ctor(self)

	self._curViewDatas = nil
	self._petHeadList = nil
	self._clickTimer = nil
end

function FamilyWarReplaceView:bindEvents()
	FamilyWarReplaceView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._replaceBtn:AddClickListener(self._onClickReplaceBtn, self)
end

function FamilyWarReplaceView:unbindEvents()
	FamilyWarReplaceView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._replaceBtn:RemoveClickListener()
end

function FamilyWarReplaceView:onExit()
	FamilyWarReplaceView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyPillarFormationInfo, self._updataRightFormaShow, self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilyPillarReplaceInfo, self.close, self)

	self._clickTimer = nil
end

function FamilyWarReplaceView:destroyUI()
	FamilyWarReplaceView.super.destroyUI(self)

	self._curViewDatas = nil
	self._petHeadList = nil
end

function FamilyWarReplaceView:buildUI()
	FamilyWarReplaceView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._replaceBtn = self:getBtn("replaceBtn")

	local formaGo = self:getGo("formaGo")

	self._petHeadList = {
		goutil.findChild(formaGo, "petHeadGo_1"),
		goutil.findChild(formaGo, "petHeadGo_2"),
		goutil.findChild(formaGo, "petHeadGo_3"),
		goutil.findChild(formaGo, "petHeadGo_4"),
		goutil.findChild(formaGo, "petHeadGo_5"),
		goutil.findChild(formaGo, "petHeadGo_6"),
		goutil.findChild(formaGo, "petHeadGo_7"),
		goutil.findChild(formaGo, "petHeadGo_8"),
		goutil.findChild(formaGo, "petHeadGo_9")
	}
	self._powerTxt = goutil.findChildTextComponent(formaGo, "powerTxt")
	self._speedTxt = goutil.findChildTextComponent(formaGo, "speedTxt")
end

function FamilyWarReplaceView:onEnter()
	FamilyWarReplaceView.super.onEnter(self)

	self._params = self:getFirstParam()

	if self._params == nil or self._params.userInfo == nil then
		printError("sr---家族战   FamilyWarReplaceView:onEnter()    请正确传入期数！！")
	end

	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyPillarFormationInfo, self._updataRightFormaShow, self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilyPillarReplaceInfo, self.close, self)

	self._tierIndexs = {}

	local count = checknumber(FamilyWarConfig.instance:getFamilyWarCommonParam("DIVINE_PILLAR_TIER_NUM"))

	if #self._params.tierInfos > 0 then
		for i = 1, #self._params.tierInfos do
			self._tierIndexs[self._params.tierInfos[i].userId] = count
			count = math.max(count - 1, 0)
		end
	else
		printError("sr---家族战  后端发送的列表个数为撒0")
	end

	self._curViewDatas = {}

	for _, info in pairs(self._params.tierInfos or {}) do
		if info and checknumber(info.userId) > 0 then
			table.insert(self._curViewDatas, info)
		end
	end

	if self._curViewDatas and #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			return a.zdl > b.zdl
		end)
	end

	self._curTargetId = self._curViewDatas[1].headInfo.userId

	if self._params.userInfo.targetUserId == self._curViewDatas[1].headInfo.userId and self._curViewDatas[2] then
		self._curTargetId = self._curViewDatas[2].headInfo.userId
	end

	self._tableview:ReloadData()
	self:_updataRightFormaShow(self._params.userInfo)
end

function FamilyWarReplaceView:_updataRightFormaShow(info)
	for i = 1, #self._petHeadList do
		MaterialMgr.resetAll(self._petHeadList[i])
	end

	if info == nil or info.otherPlayerView == nil then
		return
	end

	local power = checknumber(info.zdl)
	local speed = checknumber(info.speed)

	self._powerTxt.text = tostring(power)
	self._speedTxt.text = tostring(speed)

	local fmtView = info.otherPlayerView

	if fmtView.petSimpleView then
		local isHave = fmtView.curForm

		for i = 1, #self._petHeadList do
			if isHave then
				self:_showRightFormaPetCell(self._petHeadList[i], fmtView.curForm.pos[i], fmtView.petSimpleView)
			end
		end
	end
end

function FamilyWarReplaceView:_showRightFormaPetCell(go, petId, petSimple)
	if go == nil or checknumber(petId) <= 0 then
		return
	end

	for _, data in ipairs(petSimple or {}) do
		if data and data.petId == petId then
			local mo = BagPetMo.New()

			mo:initBaseView(data)
			MaterialMgr.setCellByMo(mo, go)

			return
		end
	end
end

function FamilyWarReplaceView:_onClickReplaceBtn()
	if not self:_clickCoolDownTips(true) then
		return
	end

	if self._curTargetId == nil or self._curTargetId == self._params.userInfo.targetUserId then
		self:close()

		return
	end

	FamilyWarController.instance:csRequestFamilyBattleAdjustReq(self._params.curTier, self._curTargetId)
end

function FamilyWarReplaceView:_clickCoolDownTips(isTips)
	local nowTime = ServerTime.now()

	if checknumber(self._clickTimer) <= 0 then
		self._clickTimer = nowTime
	else
		if nowTime - self._clickTimer < 2 then
			if isTips then
				FloatWordMgr.instance:show("点击过于频繁")
			end

			return false
		end

		self._clickTimer = now
	end

	return true
end

function FamilyWarReplaceView:_getPath()
	return {
		cellPath = "leftInfoGo/rankItem",
		viewPath = "leftInfoGo/rankListSR"
	}
end

function FamilyWarReplaceView:_cellSize()
	return 640, 108
end

function FamilyWarReplaceView:_updateCell(view, cell, data)
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local emptyTxt = goutil.findChildTextComponent(cell, "emptyTxt")
	local headGo = goutil.findChild(cell, "headGo")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")
	local choiseGo = goutil.findChild(cell, "choiseGo")

	GameUtil.asBtn(cell):RemoveClickListener()
	MaterialMgr.resetAll(headGo)

	local index = checknumber(self._tierIndexs[data.userId])

	if index > 0 then
		rankTxt.text = tostring(index)
		emptyTxt.text = ""
	else
		rankTxt.text = ""
		emptyTxt.text = "空"
	end

	nameTxt.text = data.headInfo.userName
	powerTxt.text = tostring(data.zdl)

	GameUtil.SetActive(choiseGo, self._curTargetId == data.headInfo.userId)
	HeadItemController.instance:setHeadCellByInfo(headGo, data.headInfo)
	GameUtil.asBtn(cell):AddClickListener(function()
		self._curTargetId = data.headInfo.userId

		FamilyWarController.instance:csRequestFamilyBattleViewDivinePillarTierFormationInfoReq(data.headInfo.userId)
		self._tableview:ReloadData()
	end, self)
end

return FamilyWarReplaceView
