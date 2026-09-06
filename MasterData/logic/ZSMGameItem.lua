-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/familyteamplay/view/game/zsm/ZSMGameItem.lua

module("logic.extensions.familyteamplay.view.game.zsm.ZSMGameItem", package.seeall)

local ZSMGameItem = class("ZSMGameItem")
local LuaComponentContainer = Framework.LuaComponentContainer
local CELL_SPACING_X = 200
local CELL_SPACING_Y = 275
local TAB_SAMLL = 1
local TAB_MID = 2
local TAB_BIG = 3
local SLOT_NUM = 54
local VIRUS_DATA = {
	[TAB_SAMLL] = {
		radius = 20,
		scale = 0.5,
		slotSize = 4
	},
	[TAB_MID] = {
		radius = 30,
		scale = 0.8,
		slotSize = 5
	},
	[TAB_BIG] = {
		radius = 40,
		scale = 1,
		slotSize = 7
	}
}
local ICON_SCALE = {
	0.5,
	0.6,
	0.7
}

function ZSMGameItem.GetGo(go)
	local component = LuaComponentContainer.Get(go, ZSMGameItem)

	component = component or LuaComponentContainer.Add(go, ZSMGameItem)

	return component
end

function ZSMGameItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._circle = goutil.findChild(go, "circle")
	self._virus = goutil.findChild(go, "virus")
	self._viruses = goutil.findChild(go, "viruses")
	self._icon = goutil.findChild(go, "icon")
	self._virusList = {}
end

function ZSMGameItem:OnDestroy()
	for k, v in pairs(self._virusList) do
		goutil.destroy(v.go)

		if v.farTween then
			v.farTween:Kill(false)

			v.farTween = nil
		end
	end

	table.clear(self._virusList)
	removetimer(self._rotateCircle, self)
	goutil.destroy(self._data.go)
	uGuiUtil.clearImage(self._icon)
end

function ZSMGameItem:reset()
	Framework.TransformUtil.SetLocalRotation(self._circle, 0, 0, 0)
	removetimer(self._rotateCircle, self)
end

function ZSMGameItem:init(index, data)
	self._index = index
	self._data = data

	local gameCfg = data.gameCfg

	self._prizeList = data.prizeList
	self._go = data.go

	local var_5_0 = {}

	if index % 2 == 0 then
		var_5_0.x = CELL_SPACING_X or -CELL_SPACING_X
	end

	var_5_0.y = (index - 1) * CELL_SPACING_Y

	local pos = var_5_0

	self._pos = pos
	self._circleRadius = math.random(gameCfg.circleRadius[1], gameCfg.circleRadius[2])

	local circleScale = self._circleRadius / 80

	GameUtil.setLocalScale(self._circle, circleScale, circleScale, 1)

	self._circleSpeed = math.random(gameCfg.circleSpeed[1], gameCfg.circleSpeed[2])
	self._rotateSpeed = math.random(gameCfg.rotateSpeed[1], gameCfg.rotateSpeed[2])
	self._dropId = 0

	if gameCfg.dropPlanId > 0 then
		local dropPlan = data.dropPlanCfg

		if dropPlan then
			local sum = 0

			for k, v in ipairs(dropPlan) do
				sum = sum + v.weight
			end

			local select = math.random(0, sum)

			for k, v in ipairs(dropPlan) do
				if select < v.weight then
					self._dropId = v.type

					break
				end

				select = select - v.weight
			end
		end
	end

	if checknumber(self._dropId > 0) and self._prizeList[self._dropId] ~= nil then
		uGuiUtil.setSpriteToImage(self._icon, uGuiUtil.SpriteType.BigBg, self._prizeList[self._dropId].imgPath)
		goutil.setActive(self._icon, true)

		if not ICON_SCALE[self._dropId] then
			local scale = 1

			GameUtil.setLocalScale(self._icon, scale)
		end
	else
		goutil.setActive(self._icon, false)
	end

	local smallNum = math.random(gameCfg.smallNum[1], gameCfg.smallNum[2])
	local midNum = math.random(gameCfg.midNum[1], gameCfg.midNum[2])
	local bigNum = math.random(gameCfg.bigNum[1], gameCfg.bigNum[2])

	self._divideSlot = {}

	table.clear(self._divideSlot)

	for i = 0, SLOT_NUM do
		self._divideSlot[i] = 0
	end

	local randomSlot = math.random(1, SLOT_NUM)
	local N = 3

	for i = 1, N do
		self._divideSlot[(randomSlot + i - 1) % SLOT_NUM] = 1
	end

	self:buildVirus(bigNum, TAB_BIG)
	self:buildVirus(midNum, TAB_MID)
	self:buildVirus(smallNum, TAB_SAMLL)
	goutil.setActive(data.go, true)
	GameUtil.setLocalPos(data.go, pos.x, pos.y, 0)

	local rotateTime = 0.01

	settimer(rotateTime, self._rotateCircle, self, true)
end

function ZSMGameItem:_rotateCircle()
	local eulerAngles = self._circle.transform.localRotation.eulerAngles
	local rotateAngle = self._circleSpeed

	Framework.TransformUtil.SetLocalRotation(self._circle.transform, 0, 0, eulerAngles.z + rotateAngle)

	local eulerAnglesVirus = self._viruses.transform.localRotation.eulerAngles
	local rotateAngleVirus = self._rotateSpeed

	Framework.TransformUtil.SetLocalRotation(self._viruses.transform, 0, 0, eulerAnglesVirus.z + rotateAngleVirus)
end

function ZSMGameItem:getPos()
	return self._pos
end

function ZSMGameItem:checkVirusCollision(playerPos, playerRadius)
	for k, v in pairs(self._virusList) do
		local worldPos = v.go.transform.position
		local distance = DuolaMMcontroller:calculateDistance(worldPos, playerPos) * 360

		if distance <= v.radius + playerRadius then
			return true
		end
	end

	return false
end

function ZSMGameItem:getDropId()
	return self._dropId
end

function ZSMGameItem:disappear()
	local centerWorldPos = self._go.transform.position

	uGuiUtil.clearImage(self._icon)

	for k, v in pairs(self._virusList) do
		local worldPos = v.go.transform.position
		local originX = worldPos.x
		local originY = worldPos.y
		local diffX = originX - centerWorldPos.x
		local diffY = originY - centerWorldPos.y

		v.farTween = TweenUtil.ValueTo(0, 1, 1.5, function(val)
			local scale = v.scale * (1 - val)

			GameUtil.setLocalScale(v.go, scale, scale, 1)

			local factor = val * 5 + 1

			GameUtil.setPos(v.go, originX + factor * diffX, originY + factor * diffY, 1)
		end, function()
			v.farTween:Kill(false)

			v.farTween = nil
		end, self, DG.Tweening.Ease.OutCubic)
	end
end

function ZSMGameItem:buildVirus(num, type)
	for i = 1, num do
		local angle = self:findSlot(type)

		if angle then
			local virusObj = goutil.cloneAndSetParent(self._virus, self._viruses.transform)

			goutil.setActive(virusObj, true)

			local mRadius = VIRUS_DATA[type].radius
			local x = math.cos(angle) * (mRadius + self._circleRadius + 5)
			local y = math.sin(angle) * (mRadius + self._circleRadius + 5)
			local scale = VIRUS_DATA[type].scale

			GameUtil.setLocalPos(virusObj, x, y, 0)
			GameUtil.setLocalScale(virusObj, scale, scale, 1)

			local obj = {
				type = type,
				go = virusObj,
				radius = mRadius,
				scale = scale
			}

			table.insert(self._virusList, obj)
		else
			printInfo("--------- buildVirus 没地方加virus了，或者slot不够了  " .. self._dropId)
		end
	end
end

function ZSMGameItem:findSlot(type)
	local randomSlot = math.random(1, SLOT_NUM)
	local slotSize = VIRUS_DATA[type].slotSize

	if not self:checkSlotIfEmpty(randomSlot, slotSize) then
		local emptyExist = false

		for i = 1, SLOT_NUM do
			local tempPos = (randomSlot + i) % SLOT_NUM

			if self:checkSlotIfEmpty(tempPos, slotSize) then
				randomSlot = tempPos
				emptyExist = true

				break
			end
		end

		if not emptyExist then
			return nil
		end
	end

	for i = 1, slotSize do
		local slot = (randomSlot + i - 1) % SLOT_NUM

		self._divideSlot[slot] = self._divideSlot[slot] + 1
	end

	return (randomSlot + slotSize / 2) % SLOT_NUM * (math.pi * 2) / SLOT_NUM
end

function ZSMGameItem:checkSlotIfEmpty(pos, slotSize)
	local isEmpty = true

	for i = 1, slotSize do
		local slot = (pos + i - 1) % SLOT_NUM

		if self._divideSlot[slot] > 0 then
			isEmpty = false
		end
	end

	return isEmpty
end

return ZSMGameItem
