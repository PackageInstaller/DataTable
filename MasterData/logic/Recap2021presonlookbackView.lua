-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recap2021/view/Recap2021presonlookbackView.lua

module("logic.extensions.recap2021.view.Recap2021presonlookbackView", package.seeall)

local Recap2021presonlookbackView = class("Recap2021presonlookbackView", ViewComponent)

function Recap2021presonlookbackView:ctor()
	Recap2021presonlookbackView.super.ctor(self)
end

function Recap2021presonlookbackView:unbindEvents()
	Recap2021presonlookbackView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRight:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
end

function Recap2021presonlookbackView:bindEvents()
	Recap2021presonlookbackView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnRight:AddClickListener(self._onClickbtnRight, self)
	self._btnLeft:AddClickListener(self._onClickbtnLeft, self)
end

function Recap2021presonlookbackView:buildUI()
	Recap2021presonlookbackView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRight = self:getBtn("btnRight")
	self._btnLeft = self:getBtn("btnLeft")
	self._roleconGo = self:getGo("rolecon")
	self._containerGo = self:getGo("container")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._roleChange = self:getGo("rolecon"):GetComponent(ComponentType.UIImageSpriteChange)
	self._effectGo = self:getGo("effect")
end

function Recap2021presonlookbackView:onExit()
	Recap2021presonlookbackView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._effectHandler)
	GlobalDispatcher:removeListener(Recap2021Controller.PM_Recap21GetInfoRes, self._updateUI, self)
end

function Recap2021presonlookbackView:onEnter()
	Recap2021presonlookbackView.super.onEnter(self)
	GlobalDispatcher:addListener(Recap2021Controller.PM_Recap21GetInfoRes, self._updateUI, self)
	self:_updateUI()
	self._roleChange:SetState(RoleModel.instance:getGender())
	self:_playEffect()
	Recap2021Agent.instance:sendPM_Recap21GetInfoReq()
end

function Recap2021presonlookbackView:_updateUI()
	self:_initViewDatas()
	self:_updateView()
end

function Recap2021presonlookbackView:_onClickbtnClose()
	self:close()
end

function Recap2021presonlookbackView:_onClickbtnLeft()
	self._currPage = self._currPage - 1

	self:_updateView()
end

function Recap2021presonlookbackView:_onClickbtnRight()
	self._currPage = self._currPage + 1

	self:_updateView()
end

function Recap2021presonlookbackView:_initViewDatas()
	self._viewDatas = Recap2021Model.instance:getPersonLookBackViewDatas()
	self._maxPage = #self._viewDatas
	self._minPage = 1
	self._currPage = self._minPage
end

function Recap2021presonlookbackView:_updateView()
	goutil.setActive(self._btnRight.gameObject, self._currPage < self._maxPage)
	goutil.setActive(self._btnLeft.gameObject, self._currPage > self._minPage)

	local personLookbackMo = self._viewDatas[self._currPage]

	UIStateManager.instance:popByName(personLookbackMo.viewCfg.viewName)
	self.showTabAt(self, self._containerGo, personLookbackMo.viewCfg.viewName, personLookbackMo, self)
end

function Recap2021presonlookbackView:_playEffect()
	local effName = "20220401/zhounianqingzongjie/fx_ui_zhounianzongjie_jiemian.prefab"

	self._effectHandler = UIEffectManager.instance:playEffect(self, effName, nil, 0, 0, true)

	self._effectHandler:setParent(self._effectGo.transform)
	self._effectHandler:setLocalPos(0, 0, 0)
	self._effectHandler:setScale(1)
end

return Recap2021presonlookbackView
