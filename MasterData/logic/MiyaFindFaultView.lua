-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/miya/MiyaFindFaultView.lua

module("logic.extensions.timelimitedchallenge.view.miya.MiyaFindFaultView", package.seeall)

local MiyaFindFaultView = class("MiyaFindFaultView", MiyaGameBaseView)

function MiyaFindFaultView:onExit()
	MiyaFindFaultView.super.onExit(self)
	removeresl(self._url, self._onResloadFinish, self)

	if self._res then
		self._res:Retain()
	end

	goutil.destroy(self._bigImg)

	self._bigImg = nil
	self._faults = nil
	self._circles = nil
end

function MiyaFindFaultView:buildUI()
	MiyaFindFaultView.super.buildUI(self)

	self._initBg = self:getGo("initBg")
end

function MiyaFindFaultView:onEnter()
	MiyaFindFaultView.super.onEnter(self)
end

function MiyaFindFaultView:_onResloadFinish(res)
	if res.IsSuccess then
		self._res = res

		self._res:Retain()

		local prefab = self._res:GetMainAsset()

		if prefab then
			self._bigImg = goutil.clone(prefab)

			goutil.addChildToParent(self._bigImg, self.mainGO)
			self._bigImg:SetActive(false)
			self:_buildBigImg()
		end
	end
end

function MiyaFindFaultView:_buildBigImg()
	self._faults = {}
	self._circles = {}

	local maxFaultNum = 10

	self._randomMap = GameUtil.getRandomMap(maxFaultNum, self._totalCount)

	for i = 1, maxFaultNum do
		local fault = goutil.findChild(self._bigImg, "imgDiff/diff_" .. i)

		table.insert(self._faults, fault)

		local btn = Framework.ButtonAdapter.GetFrom(fault, "btn")

		if btn then
			btn:AddClickListener(function()
				self:_onClickFault(i)
			end)
		end

		fault:SetActive(self._randomMap[i] == true)

		local circle = goutil.findChild(self._bigImg, "circle/cir_" .. i)

		table.insert(self._circles, circle)
		circle:SetActive(false)
	end

	self._btnRightImg = Framework.ButtonAdapter.GetFrom(self._bigImg, "bgR")

	self._btnRightImg:AddClickListener(self._onClickRightBg, self)

	self._btnLeftImg = Framework.ButtonAdapter.GetFrom(self._bigImg, "bgL")

	self._btnLeftImg:AddClickListener(self._onClickLeftBg, self)
end

function MiyaFindFaultView:_initGame()
	local pictureId = checknumber(self:getFirstParam())

	self._pictureCfg = MiyaGameConfig.instance:getFindFaultCfg(pictureId)
	self._totalTime = self._pictureCfg.gameTime
	self._totalCount = self._pictureCfg.passNeedNum
	self._url = string.format("ui/views/timelimitedchallenge/findfault/diff%d.prefab", self._pictureCfg.pictureIdNew)
	self._tipCountdown = langPara("miya_findfault_countdown_tip", self._totalTime, self._totalCount)

	self._initBg:SetActive(true)
	getres(self._url, self._onResloadFinish, self)
	MiyaFindFaultView.super._initGame(self)
end

function MiyaFindFaultView:_startGame()
	MiyaFindFaultView.super._startGame(self)
	self._initBg:SetActive(false)
	self._bigImg:SetActive(true)
end

function MiyaFindFaultView:_endGame()
	self._differentNum = self._findedCount

	MiyaFindFaultView.super._endGame(self)
end

function MiyaFindFaultView:_onClickFault(idx, ignoreCd)
	if ignoreCd ~= true and not self:_checkClickCd() then
		return
	end

	if self._randomMap[idx] == true then
		self._randomMap[idx] = false

		local circle = self._circles[idx]

		circle:SetActive(true)

		self._findedCount = self._findedCount + 1

		self:_updateLeftCount()
	else
		self:_reduceLeftTime()
	end
end

function MiyaFindFaultView:_onClickRightBg()
	if not self:_checkClickCd() then
		return
	end

	self:_reduceLeftTime()
end

function MiyaFindFaultView:_transPos(screenPos, originTrans, targetTrans)
	local cam = GlobalModel.instance.uiCamera
	local worldPos = cam:ScreenToWorldPoint(screenPos)
	local pos = originTrans:InverseTransformPoint(worldPos)
	local targetWorldPos = targetTrans:TransformPoint(pos)

	return cam:WorldToScreenPoint(targetWorldPos)
end

function MiyaFindFaultView:_onClickLeftBg()
	if not self:_checkClickCd() then
		return
	end

	local cam = GlobalModel.instance.uiCamera
	local screenPos = UnityEngine.Input.mousePosition
	local targetScreenPos = self:_transPos(screenPos, self._btnLeftImg.transform, self._btnRightImg.transform)

	for idx, v in pairs(self._randomMap) do
		if v == true then
			local fault = self._faults[idx]
			local rect = goutil.findChildComponent(fault, "btn", typeof(UnityEngine.RectTransform))
			local isInRect = UnityEngine.RectTransformUtility.RectangleContainsScreenPoint(rect, targetScreenPos, cam)

			if isInRect then
				self:_onClickFault(idx, true)

				return
			end
		end
	end

	self:_reduceLeftTime()
end

function MiyaFindFaultView:_reduceLeftTime()
	local reducePer = checknumber(MiyaGameConfig.instance:getConstantValue("FIND_FAULT_SUB_SEC"))

	self._tickedTime = self._tickedTime + reducePer

	FloatWordMgr.instance:show(string.format("减少%d秒", reducePer))
	self:_updateLeftTime()
end

function MiyaFindFaultView:_checkClickCd()
	local clickCd = checknumber(MiyaGameConfig.instance:getConstantValue("CLICK_CD"))
	local now = UnityEngine.Time.time

	if self._lastClickTime == nil then
		self._lastClickTime = now

		return true
	elseif clickCd < now - self._lastClickTime then
		self._lastClickTime = now - clickCd

		return true
	else
		FloatWordMgr.instance:show("还不能点击")

		return false
	end
end

return MiyaFindFaultView
