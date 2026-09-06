-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/PlotChapterItem.lua

module("logic.extensions.plotcopy.view.PlotChapterItem", package.seeall)

local PlotChapterItem = class("PlotChapterItem")
local LuaComponentContainer = Framework.LuaComponentContainer

function PlotChapterItem.AddOnce(go)
	local component = LuaComponentContainer.Get(go, PlotChapterItem)

	component = component or LuaComponentContainer.Add(go, PlotChapterItem)

	return component
end

function PlotChapterItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._uiChangeGroup = go:GetComponent("UIChangeGroup")
	self._txtChapter = goutil.findChild(go, "txtChapter"):GetComponent(goutil.Type_UIText)
	self._txtName = goutil.findChild(go, "txtName"):GetComponent(goutil.Type_UIText)
	self._imgLocked = goutil.findChild(go, "imgLocked")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")
	self._imgRedPoint = goutil.findChild(go, "imgRedPoint")
	self._imgNew = goutil.findChild(go, "imgNew")
	self._select = goutil.findChild(go, "select")
	self._imgPassed = goutil.findChild(go, "imgPassed")
	self._txtCount = goutil.findChild(go, "txtCount"):GetComponent(goutil.Type_UIText)
	self._imgPerfect = goutil.findChild(go, "imgPerfect")
end

function PlotChapterItem:OnDestroy()
	printInfo("PlotChapterItem Destroy", self._index)
end

function PlotChapterItem:init(index, data, view)
	self._index = index
	self._data = data
	self._view = view

	self._btnClick:AddClickListener(self._onBtnClick, self)

	self._txtChapter.text = data.index
	self._txtName.text = data.cfg.chapterName

	self._imgLocked:SetActive(data.isLock)
	self._imgRedPoint:SetActive(data.isShowRedPoint)
	self._select:SetActive(data.isSelect)
	self._uiChangeGroup:SetState(data.isSelect and 1 or 0)

	local isChapterPass = PlotCopyModel.instance:isChapterPassed(data.cfg.chapterId)

	goutil.setActive(self._imgPassed, isChapterPass)
	goutil.setActive(self._txtCount.gameObject, not isChapterPass)

	if not isChapterPass then
		local curCount, totalCount = PlotCopyModel.instance:getStageFinishCountExceptPurePlot(data.cfg.chapterId)

		self._txtCount.text = curCount .. "/" .. totalCount
	end

	local isPerfectPass = PlotCopyModel.instance:isChapterPerfectPassed(data.cfg.chapterId)

	goutil.setActive(self._imgPerfect, isPerfectPass)
	self:_setIsNewChapter(isPerfectPass)
end

function PlotChapterItem:reset()
	self._data = nil
	self._view = nil

	self._btnClick:RemoveClickListener()
end

function PlotChapterItem:_onBtnClick()
	GlobalDispatcher:dispatch(GlobalNotify.CopySelectChapter, self._data)
end

function PlotChapterItem:_setIsNewChapter(isPerfectPass)
	if self._data.isLock or isPerfectPass then
		self._imgNew:SetActive(false)

		return
	end

	local name = RoleModel.instance:getUserId() .. CopyConst.isNewChatper .. self._data.cfg.chapterId
	local num = UnityEngine.PlayerPrefs.GetInt(name)
	local isNew = num == 0

	self._imgNew:SetActive(isNew)
end

return PlotChapterItem
