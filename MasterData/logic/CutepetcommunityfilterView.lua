-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cutepet/view/CutepetcommunityfilterView.lua

module("logic.extensions.cutepet.view.CutepetcommunityfilterView", package.seeall)

local CutepetcommunityfilterView = class("CutepetcommunityfilterView", ViewComponent)

function CutepetcommunityfilterView:unbindEvents()
	CutepetcommunityfilterView.super.unbindEvents(self)
	self._customInput:RemoveListener()
	self._typeFilter:unbindEvents()
end

function CutepetcommunityfilterView:bindEvents()
	CutepetcommunityfilterView.super.bindEvents(self)
	self._customInput:AddListener(self._onCustomInputCallback, self)
	self._typeFilter:bindEvents()
	self._typeFilter:setValueChanged(self._updateList, self)
end

function CutepetcommunityfilterView:onExit()
	CutepetcommunityfilterView.super.onExit(self)
	GlobalDispatcher:dispatch(GlobalNotify.CutePetFilterClose)
	removetimer(self.showMainGo, self)
end

function CutepetcommunityfilterView:buildUI()
	CutepetcommunityfilterView.super.buildUI(self)

	self._content = goutil.findChild(self.mainGO, "content")
	self._adjustPosition = self._content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._content)

	local TypeFilterGo = self:getGo("content/TypeFilter")

	self._typeFilter = ItemFilterExt.New(TypeFilterGo, 1, 4, false, "Cell", "Mark")
end

function CutepetcommunityfilterView:_onCustomInputCallback(hover)
	if not hover then
		self:close()
	end
end

function CutepetcommunityfilterView:onEnter()
	CutepetcommunityfilterView.super.onEnter(self)

	local params = self._viewPresentor._openParam

	if params then
		self:_adjustView()

		self.parentPresentor = params[3]
		self.type = params[4]
		self.updateCallBack = params[5]

		self:_reinitAllItem()
		self:checkPresentor()
	end
end

function CutepetcommunityfilterView:_reinitAllItem()
	local data = CutePetFilterMgr.instance:getFilterData(self.type)

	self._typeFilter:initData(data.typeSelectList)
	self._typeFilter:initActiveList(data.typeActiveList)
	self._typeFilter:initClickAble(data.typeClickAble)
end

function CutepetcommunityfilterView:checkPresentor(callback)
	if not self.parentPresentor or not self.parentPresentor:isOpen() then
		self:close()

		return
	end

	GameUtil.callBack(callback)
end

function CutepetcommunityfilterView:_adjustView()
	local pos = self._viewPresentor._openParam[1]

	self.pos = pos
	self.sizeDelta = self._viewPresentor._openParam[2]

	if pos then
		GameUtil.SetActive(self.mainGO, false)
		settimer(0.1, self.showMainGo, self, false)
	else
		Framework.TransformUtil.SetLocalPos(self._content.transform, 0, 0, 0)
	end
end

function CutepetcommunityfilterView:showMainGo()
	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(self.pos, self.sizeDelta[1], self.sizeDelta[2])

	local pos = GameUtil.getLocalPos(self._content)

	GameUtil.setLocalPos(self._content, pos.x, pos.y, pos.z)
	self:checkPresentor()
end

function CutepetcommunityfilterView:_updateList()
	self:checkPresentor(function()
		local data = CutePetFilterMgr.instance:getFilterData(self.type)

		data.typeSelectList = self._typeFilter:getData()

		GameUtil.callBack(self.updateCallBack)
	end)
end

return CutepetcommunityfilterView
