-- chunkname: @modules/logic/playercard/view/comp/BasePlayerCardComp.lua

module("modules.logic.playercard.view.comp.BasePlayerCardComp", package.seeall)

local BasePlayerCardComp = class("BasePlayerCardComp", LuaCompBase)

function BasePlayerCardComp:ctor(param)
	if param then
		for k, v in pairs(param) do
			self[k] = v
		end
	end
end

function BasePlayerCardComp:init(go)
	self.viewGO = go
	self.goSelect = gohelper.setActive(go, "#go_select")

	self:setEditMode(false)
	self:onInitView()
end

function BasePlayerCardComp:refreshView(info)
	self.cardInfo = info

	self:onRefreshView()
end

function BasePlayerCardComp:isPlayerSelf()
	return self.cardInfo and self.cardInfo:isSelf()
end

function BasePlayerCardComp:getPlayerInfo()
	return self.cardInfo and self.cardInfo:getPlayerInfo()
end

function BasePlayerCardComp:onInitView()
	return
end

function BasePlayerCardComp:onRefreshView()
	return
end

function BasePlayerCardComp:addEventListeners()
	return
end

function BasePlayerCardComp:removeEventListeners()
	return
end

function BasePlayerCardComp:setEditMode(isEdit)
	gohelper.setActive(self.goSelect, isEdit)
end

return BasePlayerCardComp
