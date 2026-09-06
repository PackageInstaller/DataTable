-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/controller/MainUIJumpController.lua

module("logic.extensions.mainui.controller.MainUIJumpController", package.seeall)

local MainUIJumpController = class("MainUIJumpController", BaseController)
local Limit = 5
local GAP = 8

function MainUIJumpController:ctor()
	MainUIJumpController.super.ctor(self)
end

function MainUIJumpController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.RedPointUpdate, self._updateRedpoint, self, NotifyPriority.Low)
	GlobalDispatcher:addListener(GlobalNotify.RedPointSetCommandChange, self._handleRedPointSetCommandChange, self)
end

function MainUIJumpController:onReset()
	self.index = 0
end

function MainUIJumpController:_handleRedPointSetCommandChange(commandId)
	local commandData = RedPointSetConfig.instance:getRdsCommandData(commandId)

	if commandData.commandType == RedPointSetEnum.CommandTypes_MainHudQuickEntry then
		self:_updateRedpoint()
	end
end

function MainUIJumpController:_updateRedpoint()
	self:_realShowBottomItems()
	self:_realShowRightItems()
end

function MainUIJumpController:_realShowBottomItems()
	self._dataBottomList = {}

	local list = FuncOpenConfig.instance:getJumpList()

	for i, cfg in ipairs(list) do
		local isOff = checknumber(cfg.isOff) ~= 1
		local isOn = RedPointSetController.instance:isOnOfMainHudQuickEntry()

		if isOff and not isOn then
			local funcId = cfg.funcId

			if funcId > 0 and FuncOpenModel.instance:getFuncIsOpen(funcId) then
				local arr = string.split(cfg.redId, "#")
				local boo = false

				for i, v in ipairs(arr or {}) do
					boo = boo or RedPointModel.instance:isActive(v)

					if boo == true then
						break
					end
				end

				if boo then
					table.insert(self._dataBottomList, cfg)
				end
			end
		end
	end

	ArraySort.sortOn(self._dataBottomList, "sortValue")

	if self._bottomCenterGo then
		if self._dataBottomList then
			self.index = self.index + 1

			local w = 0

			for i = 1, Limit do
				local cfg = self._dataBottomList[i]

				if cfg then
					local ww = checknumber(cfg.width)

					if ww == 0 then
						ww = 78
					end

					local go = self:createOrGetCell(cfg, self._bottomCenterGo, MatType.Item_Jump)
					local mo = GameUtil.GetLua(go, MainUIJumpMo)

					mo:setToX(w, self.index)

					w = w + ww + GAP
				end
			end

			GameUtil.setAnchoredPos(self._bottomCenterGo, 50 - (w - GAP) * 0.5, -255)
		end

		local trs = self._bottomCenterGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)
			local mo = GameUtil.GetLua(child, MainUIJumpMo)

			mo:tryRmove(self.index)
		end
	end
end

function MainUIJumpController:_realShowRightItems()
	self._dataRightJumpList = {}

	local list = FuncOpenConfig.instance:getJumpRightList()

	for i, cfg in ipairs(list) do
		if checknumber(cfg.isOff) ~= 1 then
			local funcId = cfg.funcId

			if funcId > 0 and FuncOpenModel.instance:getFuncIsOpen(funcId) then
				local arr = string.split(cfg.redId, "#")
				local boo = false

				for i, v in ipairs(arr or {}) do
					boo = boo or RedPointModel.instance:isActive(v)

					if boo == true then
						break
					end
				end

				if boo then
					table.insert(self._dataRightJumpList, cfg)
				end
			end
		end
	end

	ArraySort.sortOn(self._dataRightJumpList, "sortValue")

	if self._rightGo then
		if self._dataRightJumpList then
			self.index = self.index + 1

			local w = 0

			for i = 1, Limit do
				local cfg = self._dataRightJumpList[i]

				if cfg then
					local ww = checknumber(cfg.width)

					if ww == 0 then
						ww = -230
					end

					local go = self:createOrGetCell(cfg, self._rightGo, MatType.Item_Jump_Right)
					local mo = GameUtil.GetLua(go, MainUIJumpMo)

					mo:setToX(w, self.index)

					w = w + ww
				end
			end
		end

		local trs = self._rightGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)
			local mo = GameUtil.GetLua(child, MainUIJumpMo)

			mo:tryRmove(self.index)
		end
	end
end

function MainUIJumpController:getJumpCellById(cfg, parentGO)
	local trs = parentGO.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1)
		local mo = GameUtil.GetLua(child, MainUIJumpMo)

		if mo and mo.cfg == cfg then
			return child.gameObject
		end
	end

	return nil
end

function MainUIJumpController:createOrGetCell(cfg, parentGO, matType)
	local go = self:getJumpCellById(cfg, parentGO)

	if go == nil then
		go = self:createCell(cfg, parentGO, matType)
	end

	return go
end

function MainUIJumpController:createCell(cfg, parentGO, matType)
	local go = goutil.create("JumpCell_" .. cfg.id, true)
	local trans = go:GetComponent(goutil.Type_RectTransform)

	trans.anchorMin = Vector2.New(0.5, 0.5)
	trans.anchorMax = Vector2.New(0.5, 0.5)
	trans.pivot = Vector2.New(0, 0)

	local ww, hh = cfg.width, cfg.height

	if checknumber(cfg.width) == 0 then
		ww = 78
	end

	if checknumber(cfg.height) == 0 then
		hh = 70
	end

	goutil.setWidth(trans, ww)
	goutil.setHeight(trans, hh)

	local mo = GameUtil.AddLuaOnce(go, MainUIJumpMo)

	mo:setCfgData(cfg, self._parentPresentor, matType)
	goutil.addChildToParent(go, parentGO)

	return go
end

function MainUIJumpController:setPresentor(presentor)
	self._parentPresentor = presentor
end

function MainUIJumpController:setMainBottomCenterGo(go)
	if go ~= nil then
		self._bottomCenterGo = go

		self:_updateRedpoint()
	else
		self:_clearAllItems(self._bottomCenterGo)

		self._bottomCenterGo = go
	end
end

function MainUIJumpController:setMainRightGo(go)
	if go ~= nil then
		self._rightGo = go

		self:_updateRedpoint()
	else
		self:_clearAllItems(self._rightGo)

		self._rightGo = go
	end
end

function MainUIJumpController:_clearAllItems(go)
	if go and not goutil.isNil(go) then
		local trs = go.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)
			local mo = GameUtil.GetLua(child, MainUIJumpMo)

			mo:dispose()
			UnityEngine.GameObject.Destroy(child.gameObject)
		end

		trs:DetachChildren()
	end
end

MainUIJumpController.instance = MainUIJumpController.New()

return MainUIJumpController
