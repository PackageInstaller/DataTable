-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/petRace/view/component/PetRaceTeamCellForRegist.lua

PetRaceTeamCellForRegist = class("PetRaceTeamCellForRegist", DisposableObject, _M)

PetRaceTeamCellForRegist:has("_viewFactory", {
	is = "r"
}):injectWith("legs.ViewFactoryAdapter")
PetRaceTeamCellForRegist:has("_petRaceSystem", {
	is = "r"
}):injectWith("PetRaceSystem")

function PetRaceTeamCellForRegist:initialize(data)
	super.initialize(self)

	self._argData = data
end

function PetRaceTeamCellForRegist:userInject()
	local resFile = "asset/ui/Node_petTeamCell.csb"

	self._cell1 = self:getViewFactory():createViewByResourceId(resFile)
	self._view = cc.Node:create()

	self._view:addChild(self._cell1)

	self._mediator = self._argData.mediator

	self:setupView(self._argData)
end

function PetRaceTeamCellForRegist:dispose()
	super.dispose()
end

function PetRaceTeamCellForRegist:getView()
	return self._view
end

function PetRaceTeamCellForRegist:update(data, index)
	self._dataIndex = data.index

	if data.selectIndex == self._dataIndex then
		self._bg_frame1:setVisible(true)
	else
		self._bg_frame1:setVisible(false)
	end

	self._round1:setString(self._dataIndex)

	if data.teamInfo then
		if not data.teamInfo[1] then
			local dataNew = {}
			local node_role = self._cell1:getChildByFullName("Panel_base.Node_role")

			self._petRaceSystem:refreshIconEmbattle(dataNew, node_role)
			self._text_power1:setString(data.combatInfo[1])
			self._text_cost1:setString(string.format("%d/%d", data.costInfo[1], data.limit))
			self._text_speed:setString(tostring(data.speedInfo[1]))
		end
	end
end

function PetRaceTeamCellForRegist:setupView(data)
	self._round1 = self._cell1:getChildByFullName("Panel_base.Text_num")
	self._text_power1 = self._cell1:getChildByFullName("Panel_base.Text_power")
	self._text_cost1 = self._cell1:getChildByFullName("Panel_base.Text_cost")
	self._text_speed = self._cell1:getChildByFullName("Panel_base.Text_speed")
	self._bg1 = self._cell1:getChildByFullName("Panel_base.Image_bg")

	self._bg1:setTouchEnabled(true)
	self._bg1:setSwallowTouches(false)

	self._bg_frame1 = self._cell1:getChildByFullName("Panel_base.Image_bg_frame")
	self._dataIndex = data.index

	self._mediator:mapButtonHandlerClick("Panel_base.Image_bg", function()
		data.touchCallBack(self._dataIndex)
	end, self._cell1)
end
