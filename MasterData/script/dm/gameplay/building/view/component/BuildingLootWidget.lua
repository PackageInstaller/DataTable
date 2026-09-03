-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/building/view/component/BuildingLootWidget.lua

BuildingLootWidget = class("BuildingLootWidget", DmBaseUI)

BuildingLootWidget:has("_buildingMediator", {
	is = "rw"
})

function BuildingLootWidget:initialize(view)
	super.initialize(self, view)
	self:setupView()
end

function BuildingLootWidget:dispose()
	super.dispose(self)
end

function BuildingLootWidget:setupView()
	return
end

local lootCount = 10

function BuildingLootWidget:dropLoot(dropPoint, item)
	local function changePos(inPos)
		if inPos then
			local outPos = cc.p(0, 0)
			local worldPos = self:getView():convertToWorldSpace(cc.p(0, 0))

			return (cc.p(inPos.x - worldPos.x, inPos.y - worldPos.y))
		end
	end

	local count = lootCount
	local numLab = item.numLab
	local type = item.type
	local lootItem = BuildingLoot:new(type)
	local endWordPos = changePos(self._buildingMediator:getLoopWordPos(type))

	dropPoint = changePos(dropPoint)

	if numLab then
		numLab:addTo(self:getView(), 99999)
		numLab:setPosition(cc.p(dropPoint.x, dropPoint.y))

		local action1 = cc.MoveTo:create(0.5, cc.p(dropPoint.x, dropPoint.y + 60))
		local callbackFunc = cc.CallFunc:create(function()
			numLab:removeFromParent()
		end)

		numLab:runAction(cc.Sequence:create(action1, callbackFunc))
	end

	if endWordPos then
		local function landCallback(itemDrop)
			local function collectCallback()
				return
			end

			lootItem:beCollectedOne(itemDrop, endWordPos, collectCallback)
		end

		lootItem:splashItems(self:getView(), dropPoint, count, landCallback)
	end
end
