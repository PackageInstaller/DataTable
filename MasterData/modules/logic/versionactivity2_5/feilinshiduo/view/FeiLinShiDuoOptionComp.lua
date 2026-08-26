-- chunkname: @modules/logic/versionactivity2_5/feilinshiduo/view/FeiLinShiDuoOptionComp.lua

module("modules.logic.versionactivity2_5.feilinshiduo.view.FeiLinShiDuoOptionComp", package.seeall)

local FeiLinShiDuoOptionComp = class("FeiLinShiDuoOptionComp", LuaCompBase)

function FeiLinShiDuoOptionComp:init(go)
	self.go = go
	self.trans = self.go.transform
end

function FeiLinShiDuoOptionComp:initData(mapItemInfo, viewCls)
	self.itemInfo = mapItemInfo
	self.sceneViewCls = viewCls
	self.playerGO = viewCls:getPlayerGO()
	self.playerTrans = self.playerGO.transform
	self.refId = self.itemInfo.refId
	self.doorItemInfo = nil
	self.curOpenState = false
end

function FeiLinShiDuoOptionComp:addEventListeners()
	FeiLinShiDuoGameController.instance:registerCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoOptionComp:removeEventListeners()
	FeiLinShiDuoGameController.instance:unregisterCallback(FeiLinShiDuoEvent.resetGame, self.resetData, self)
end

function FeiLinShiDuoOptionComp:resetData()
	self.curOpenState = false
end

function FeiLinShiDuoOptionComp:onTick()
	self:initDoorItem()
	self:handleEvent()
end

function FeiLinShiDuoOptionComp:initDoorItem()
	if not self.doorItemInfo then
		local elementMap = FeiLinShiDuoGameModel.instance:getElementMap()

		if not elementMap[FeiLinShiDuoEnum.ObjectType.Door] then
			for _, item in pairs(elementMap[FeiLinShiDuoEnum.ObjectType.Door]) do
				if item.refId == self.refId then
					self.doorItemInfo = item

					break
				end
			end

			if not self.doorItemInfo then
				return
			end

			local elementGOMap = self.sceneViewCls:getElementGOMap()

			self.doorGO = elementGOMap[self.doorItemInfo.id].subGOList[1]
			self.boxElementMap = elementMap[FeiLinShiDuoEnum.ObjectType.Box]
			self.doorAnim = self.doorGO:GetComponent(gohelper.Type_Animator)
			self.curOpenState = false
			self.optionGO = elementGOMap[self.itemInfo.id].subGOList[1]
			self.optionAnim = self.optionGO:GetComponent(gohelper.Type_Animator)
		end
	end
end

function FeiLinShiDuoOptionComp:handleEvent()
	if not self.sceneViewCls or not self.doorItemInfo then
		return
	end

	self:checkTouchBoxOrPlayer()
end

function FeiLinShiDuoOptionComp:checkTouchBoxOrPlayer()
	local isTouchElementList = FeiLinShiDuoGameModel.instance:checkItemTouchElemenet(self.trans.localPosition.x, self.trans.localPosition.y - 1, self.itemInfo, FeiLinShiDuoEnum.checkDir.Top, self.boxElementMap)
	local isPlayerTouch = self.playerTrans.localPosition.x > self.itemInfo.pos[1] and self.playerTrans.localPosition.x < self.itemInfo.pos[1] + self.itemInfo.width and self.playerTrans.localPosition.y > self.itemInfo.pos[2] - 1 and self.playerTrans.localPosition.y < self.itemInfo.pos[2] + self.itemInfo.height

	self:setOpenState((isTouchElementList and #isTouchElementList > 0 or isPlayerTouch or nil) and true)
end

function FeiLinShiDuoOptionComp:setOpenState(isOpen)
	if self.curOpenState ~= isOpen then
		self.curOpenState = isOpen

		self.optionAnim:Play(isOpen and "in" or "out")
		self.doorAnim:Play(isOpen and "out" or "in")

		if isOpen then
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_door_open)
		else
			AudioMgr.instance:trigger(AudioEnum.FeiLinShiDuo.play_ui_tangren_door_close)
		end

		FeiLinShiDuoGameModel.instance:setDoorOpenState(self.doorItemInfo.id, self.curOpenState)
	end
end

return FeiLinShiDuoOptionComp
