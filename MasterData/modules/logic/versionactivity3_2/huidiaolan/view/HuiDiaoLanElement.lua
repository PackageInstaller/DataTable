-- chunkname: @modules/logic/versionactivity3_2/huidiaolan/view/HuiDiaoLanElement.lua

module("modules.logic.versionactivity3_2.huidiaolan.view.HuiDiaoLanElement", package.seeall)

local HuiDiaoLanElement = class("HuiDiaoLanElement", LuaCompBase)

function HuiDiaoLanElement:ctor(param)
	self.param = param
end

function HuiDiaoLanElement:init(go)
	self:__onInit()

	self.go = go
	self.root = gohelper.findChild(self.go, "root")
	self.goLevel1 = gohelper.findChild(self.root, "go_level1")
	self.goLevel2 = gohelper.findChild(self.root, "go_level2")
	self.goLevel3 = gohelper.findChild(self.root, "go_level3")

	for color = 1, 3 do
		self["goLevel1Color" .. color] = gohelper.findChild(self.goLevel1, HuiDiaoLanEnum.ElementGoName[color])
	end

	self.animLevel1 = self.goLevel1:GetComponent(gohelper.Type_Animator)
	self.animLevel2 = self.goLevel2:GetComponent(gohelper.Type_Animator)
	self.animLevel3 = self.goLevel3:GetComponent(gohelper.Type_Animator)
end

function HuiDiaoLanElement:addEventListeners()
	return
end

function HuiDiaoLanElement:removeEventListeners()
	return
end

function HuiDiaoLanElement:playSwitchAnim(beforeColor, nowColor)
	if not self.go then
		self:cancelAllTask()

		return
	end

	if self.level == 1 then
		self.animLevel1:Play("switch", 0, 0)
		self.animLevel1:Update(0)

		self.beforeColor = beforeColor
		self.nowColor = nowColor

		gohelper.setActive(self["goLevel1Color" .. beforeColor], true)
		gohelper.setActive(self["goLevel1Color" .. nowColor], false)
		TaskDispatcher.runDelay(self.showNowColor, self, 0.16)
		TaskDispatcher.runDelay(self.playIdleAnim, self, 0.5)
	end
end

function HuiDiaoLanElement:showNowColor()
	gohelper.setActive(self["goLevel1Color" .. self.beforeColor], false)
	gohelper.setActive(self["goLevel1Color" .. self.nowColor], true)
end

function HuiDiaoLanElement:playBornAnim()
	if self.level == 1 then
		self.animLevel1:Play("open", 0, 0)
		self.animLevel1:Update(0)
	end
end

function HuiDiaoLanElement:playMoveAnim()
	if not self.go then
		self:cancelAllTask()

		return
	end

	if self.level == 1 then
		self.animLevel1:Play("move", 0, 0)
		self.animLevel1:Update(0)
	elseif self.level == 2 then
		self.animLevel2:Play("move", 0, 0)
		self.animLevel2:Update(0)
	end
end

function HuiDiaoLanElement:playIdleAnim()
	if not self.go then
		self:cancelAllTask()

		return
	end

	if self.level == 1 then
		self.animLevel1:Play("idle", 0, 0)
		self.animLevel1:Update(0)
	elseif self.level == 2 then
		self.animLevel2:Play("idle", 0, 0)
		self.animLevel2:Update(0)
	end
end

function HuiDiaoLanElement:playDiamondFlyoutAnim()
	if not self.go then
		self:cancelAllTask()

		return
	end

	if self.level == 3 then
		self.animLevel3:Play("fly", 0, 0)
		self.animLevel3:Update(0)
	end
end

function HuiDiaoLanElement:setRootScale(gameInfoData)
	local planeItemWidth = gameInfoData.planeItemWidth
	local sizeScale = planeItemWidth / HuiDiaoLanEnum.PlaneWidth

	transformhelper.setLocalScale(self.root.transform, sizeScale, sizeScale, 1)
end

function HuiDiaoLanElement:refreshUI(elementData)
	if not elementData or not next(elementData) then
		gohelper.setActive(self.go, false)

		return
	end

	gohelper.setActive(self.go, true)

	self.posIndex = elementData.posIndex or "0#0"
	self.color = elementData.color or HuiDiaoLanEnum.ElementColor.Red
	self.level = elementData.level or 1

	gohelper.setActive(self.goLevel1, self.level == 1)
	gohelper.setActive(self.goLevel2, self.level == 2)
	gohelper.setActive(self.goLevel3, self.level == 3)

	self.curShowLevelGo = self["goLevel" .. self.level]

	if self.level < 2 then
		for color = 1, 3 do
			gohelper.setActive(self[string.format("goLevel%dColor%d", self.level, color)], self.color == color)
		end
	end

	self.go.name = "elementItem" .. self.posIndex
end

function HuiDiaoLanElement:getPosIndex()
	return self.posIndex
end

function HuiDiaoLanElement:getColor()
	return self.color
end

function HuiDiaoLanElement:getLevel()
	return self.level
end

function HuiDiaoLanElement:cancelAllTask()
	TaskDispatcher.cancelTask(self.showNowColor, self)
	TaskDispatcher.cancelTask(self.playIdleAnim, self)
end

function HuiDiaoLanElement:onDestroy()
	self:cancelAllTask()
end

return HuiDiaoLanElement
