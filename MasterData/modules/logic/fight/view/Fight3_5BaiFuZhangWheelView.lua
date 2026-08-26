-- chunkname: @modules/logic/fight/view/Fight3_5BaiFuZhangWheelView.lua

module("modules.logic.fight.view.Fight3_5BaiFuZhangWheelView", package.seeall)

local Fight3_5BaiFuZhangWheelView = class("Fight3_5BaiFuZhangWheelView", FightBaseView)

function Fight3_5BaiFuZhangWheelView:onInitView()
	self.normalRoot = gohelper.findChild(self.viewGO, "root/normal")
	self.specialRoot = gohelper.findChild(self.viewGO, "root/special")
end

function Fight3_5BaiFuZhangWheelView:addEvents()
	return
end

function Fight3_5BaiFuZhangWheelView:removeEvents()
	return
end

function Fight3_5BaiFuZhangWheelView:_onBtnEsc()
	return
end

function Fight3_5BaiFuZhangWheelView:onOpen()
	NavigateMgr.instance:addEscape(self.viewContainer.viewName, self._onBtnEsc, self)

	local battleId = FightDataHelper.fieldMgr.battleId

	if battleId == 117351010 then
		gohelper.setActive(self.normalRoot, false)
		gohelper.setActive(self.specialRoot, true)
		self:com_openSubView(Fight3_5BaiFuZhangSpecialWheelView, self.specialRoot, nil, self.viewParam)
	else
		gohelper.setActive(self.normalRoot, true)
		gohelper.setActive(self.specialRoot, false)
		self:com_openSubView(Fight3_5BaiFuZhangNormalWheelView, self.normalRoot, nil, self.viewParam)
	end
end

function Fight3_5BaiFuZhangWheelView:onClose()
	return
end

function Fight3_5BaiFuZhangWheelView:onDestroyView()
	return
end

return Fight3_5BaiFuZhangWheelView
