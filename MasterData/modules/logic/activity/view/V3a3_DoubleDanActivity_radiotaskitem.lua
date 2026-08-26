-- chunkname: @modules/logic/activity/view/V3a3_DoubleDanActivity_radiotaskitem.lua

module("modules.logic.activity.view.V3a3_DoubleDanActivity_radiotaskitem", package.seeall)

local V3a3_DoubleDanActivity_radiotaskitem = class("V3a3_DoubleDanActivity_radiotaskitem", RougeSimpleItemBase)

function V3a3_DoubleDanActivity_radiotaskitem:onInitView()
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a3_DoubleDanActivity_radiotaskitem:addEvents()
	return
end

function V3a3_DoubleDanActivity_radiotaskitem:removeEvents()
	return
end

function V3a3_DoubleDanActivity_radiotaskitem:ctor(ctorParam)
	V3a3_DoubleDanActivity_radiotaskitem.super.ctor(self, ctorParam)
end

function V3a3_DoubleDanActivity_radiotaskitem:_editableInitView()
	V3a3_DoubleDanActivity_radiotaskitem.super._editableInitView(self)

	self._txtDateUnSelected = gohelper.findChildText(self.viewGO, "txt_DateUnSelected")
	self._goDateSelected = gohelper.findChild(self.viewGO, "image_Selected")
	self._txtDateSelected = gohelper.findChildText(self.viewGO, "image_Selected/txt_DateSelected")
	self._goDateLocked = gohelper.findChild(self.viewGO, "image_Locked")
	self._goRed = gohelper.findChild(self.viewGO, "#go_reddot")
	self._click = gohelper.findChildButtonWithAudio(self.viewGO, "btn_click")
	self._txtDateUnSelectedGo = self._txtDateUnSelected.gameObject
end

function V3a3_DoubleDanActivity_radiotaskitem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function V3a3_DoubleDanActivity_radiotaskitem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function V3a3_DoubleDanActivity_radiotaskitem:onSelect(isSelect)
	gohelper.setActive(self._goDateSelected, isSelect)
	gohelper.setActive(self._txtDateUnSelectedGo, not isSelect)
end

function V3a3_DoubleDanActivity_radiotaskitem:_isDayOpen()
	return self:_assetGetViewContainer():isDayOpen(self._index)
end

function V3a3_DoubleDanActivity_radiotaskitem:_isType101RewardCouldGet()
	return self:_assetGetViewContainer():isType101RewardCouldGet(self._index)
end

function V3a3_DoubleDanActivity_radiotaskitem:setData()
	local isLock = not self:_isDayOpen()
	local showReddot = self:_isType101RewardCouldGet()
	local titleStr = formatLuaLang("warmup_radiotaskitem_day", self._index)

	self._txtDateUnSelected.text = titleStr
	self._txtDateSelected.text = titleStr

	gohelper.setActive(self._goDateLocked, isLock)
	gohelper.setActive(self._goRed, showReddot)
end

function V3a3_DoubleDanActivity_radiotaskitem:_onClick()
	local p = self:_assetGetParent()

	if not self:_isDayOpen() then
		GameFacade.showToast(ToastEnum.V2a0WarmupEpisodeNotOpen)

		return
	end

	p:onClickTab(self)
end

function V3a3_DoubleDanActivity_radiotaskitem:onDestroyView()
	V3a3_DoubleDanActivity_radiotaskitem.super.onDestroyView(self)
end

return V3a3_DoubleDanActivity_radiotaskitem
