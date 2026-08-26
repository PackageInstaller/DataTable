-- chunkname: @modules/logic/survival/view/map/comp/SurvivalMapSelectItem.lua

module("modules.logic.survival.view.map.comp.SurvivalMapSelectItem", package.seeall)

local SurvivalMapSelectItem = class("SurvivalMapSelectItem", LuaCompBase)

function SurvivalMapSelectItem:ctor(params)
	self._callback = params.callback
	self._callobj = params.callobj
	self._mapInfo = params.mapInfo
	self._index = params.index
	self.maxRichness = params.maxRichness
	self.name = params.name
end

function SurvivalMapSelectItem:init(go)
	self._anim = gohelper.findChildAnim(go, "")
	self._golocked = gohelper.findChild(go, "locked")
	self._txtnamelock = gohelper.findChildTextMesh(go, "locked/namebg/txt_map")
	self._gounlock = gohelper.findChild(go, "unlock")
	self._txtnameunlock = gohelper.findChildTextMesh(go, "unlock/namebg/txt_map")
	self._goselect = gohelper.findChild(go, "unlock/#go_select")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#btn_click")
	self._gorecommend = gohelper.findChild(go, "#go_recommend")

	self:_refreshView()
end

function SurvivalMapSelectItem:addEventListeners()
	self._btnclick:AddClickListener(self._onClick, self)
end

function SurvivalMapSelectItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function SurvivalMapSelectItem:_refreshView()
	self._isLock = not self._mapInfo

	gohelper.setActive(self._golocked, self._isLock)
	gohelper.setActive(self._gounlock, not self._isLock)

	if self._mapInfo then
		local name = self._mapInfo.groupCo.name

		self._txtnamelock.text = GameUtil.setFirstStrSize(name, 56)
		self._txtnameunlock.text = GameUtil.setFirstStrSize(name, 56)
	else
		self._txtnamelock.text = GameUtil.setFirstStrSize(self.name, 56)
	end

	gohelper.setActive(self._gorecommend, not self._isLock and self._mapInfo.groupCo.mapRichness >= self.maxRichness)
end

function SurvivalMapSelectItem:playUnlockAnim()
	gohelper.setActive(self._golocked, true)
	gohelper.setActive(self._gounlock, true)
	self._anim:Play("unlock", 0, 0)
end

function SurvivalMapSelectItem:_onClick()
	if not self._mapInfo then
		return
	end

	self._callback(self._callobj, self._index)
end

function SurvivalMapSelectItem:setIsSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)
end

return SurvivalMapSelectItem
