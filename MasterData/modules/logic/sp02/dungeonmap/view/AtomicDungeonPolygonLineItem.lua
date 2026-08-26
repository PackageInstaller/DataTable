-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicDungeonPolygonLineItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicDungeonPolygonLineItem", package.seeall)

local AtomicDungeonPolygonLineItem = class("AtomicDungeonPolygonLineItem", LuaCompBase)
local WAIT_TIME = 0.5

function AtomicDungeonPolygonLineItem:ctor(param)
	self.config = param[1]
	self.preElementId = param[2]
	self.sceneElements = param[3]
	self.preElementMo = AtomicDungeonModel.instance:getElementMo(self.preElementId)
	self.iskeyLine = self.config.type == AtomicDungeonEnum.ElementType.KeyDoor and not string.nilorempty(self.config.parm) and tonumber(self.config.parm) == AtomicDungeonEnum.PolygonKeyDoorType.Key
end

function AtomicDungeonPolygonLineItem:init(go)
	self.go = go
	self.goFinish = gohelper.findChild(self.go, "go_finish")
	self.goUnFinish = gohelper.findChild(self.go, "go_unfinish")
	self.goKey = gohelper.findChild(self.go, "go_key")
	self.anim = self.go:GetComponent(gohelper.Type_Animator)
end

function AtomicDungeonPolygonLineItem:refreshUI(needTween, posData)
	if not self.preElementMo then
		gohelper.setActive(self.go, false)

		return
	end

	local isPreElementFinish = AtomicDungeonModel.instance:isElementFinish(self.preElementId)

	if not isPreElementFinish then
		gohelper.setActive(self.go, false)

		return
	end

	local isElemenetFinish = AtomicDungeonModel.instance:isElementFinish(self.config.id)

	gohelper.setActive(self.go, true)
	gohelper.setActive(self.goFinish, isElemenetFinish and not self.iskeyLine)
	gohelper.setActive(self.goUnFinish, not isElemenetFinish and not self.iskeyLine)
	gohelper.setActive(self.goKey, self.iskeyLine)

	local curPosData = string.nilorempty(self.config.pos) and {
		0,
		0,
		0
	} or string.splitToNumber(self.config.pos, "#")

	if self.iskeyLine then
		local keyElementData = AtomicDungeonModel.instance:getKeyElementData(self.config.id)

		curPosData = {
			keyElementData.posX,
			keyElementData.posY,
			0
		}
	end

	if posData and next(posData) then
		curPosData = posData
	end

	local preElementCo = AtomicDungeonConfig.instance:getElementConfig(self.preElementId)
	local prePosData = string.nilorempty(preElementCo.pos) and {
		0,
		0,
		0
	} or string.splitToNumber(preElementCo.pos, "#")
	local curPos = Vector2(curPosData[1] / AtomicDungeonEnum.PolygonElementScale, curPosData[2] / AtomicDungeonEnum.PolygonElementScale)
	local prePos = Vector2(prePosData[1] / AtomicDungeonEnum.PolygonElementScale, prePosData[2] / AtomicDungeonEnum.PolygonElementScale)

	recthelper.setAnchor(self.go.transform, prePos.x, prePos.y)

	local angle = Mathf.Atan2(curPos.y - prePos.y, curPos.x - prePos.x) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(self.go.transform, 0, 0, angle)

	self.distance = Vector2.Distance(curPos, prePos)

	if needTween then
		recthelper.setWidth(self.go.transform, 0)

		self.tweenId = ZProj.TweenHelper.DOWidth(self.go.transform, self.distance, WAIT_TIME, self.lineMoveTweenFinish, self)

		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_gudu_kaishi)
	else
		recthelper.setWidth(self.go.transform, self.distance)
	end
end

function AtomicDungeonPolygonLineItem:lineMoveTweenFinish()
	recthelper.setWidth(self.go.transform, self.distance)
end

function AtomicDungeonPolygonLineItem:cleanTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function AtomicDungeonPolygonLineItem:playHideAnim()
	self.anim:Play("close", 0, 0)
	self.anim:Update(0)
end

function AtomicDungeonPolygonLineItem:onDestroy()
	self:cleanTween()
end

return AtomicDungeonPolygonLineItem
