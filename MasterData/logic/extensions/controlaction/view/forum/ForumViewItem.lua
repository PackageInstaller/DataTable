-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/controlaction/view/forum/ForumViewItem.lua

module("logic.extensions.controlaction.view.forum.ForumViewItem", package.seeall)

local M = class("ForumViewItem")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject

	self:_buildUI()
end

function M:_buildUI()
	self._bgScretGo = goutil.findChild(self._mainGo, "secretDi")
	self._bgNormalGo = goutil.findChild(self._mainGo, "normalDi")
	self._txtContent = goutil.findChildComponent(self._mainGo, "txtContent", UIComponentType.TextMeshProUGUI)
	self._txtName = goutil.findChildComponent(self._mainGo, "txtName", UIComponentType.TextMeshProUGUI)
	self._txtTime = goutil.findChildComponent(self._mainGo, "txtTime", UIComponentType.TextMeshProUGUI)
	self._txtLikeCount = goutil.findChildComponent(self._mainGo, "txtGoodNum", UIComponentType.TextMeshProUGUI)
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "txtContent/click"))
	self._likeFlagGo = goutil.findChild(self._mainGo, "btnGood/type1")
	self._unlikeFlagGo = goutil.findChild(self._mainGo, "btnGood/type2")
	self._animation = self._mainGo:GetComponent(ComponentType.Animation)

	self:_bindEvents()
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClick()
	if ControlActionUtil.isInGuide() then
		GlobalDispatcher:dispatchEvent(EventType.CONTROLACTION_FORUM_POSTREPLY, self._themePostMo)
	else
		ControlActionAgent.instance:sendGetPostRequest(self._themePostMo:getId())
	end
end

function M:refresh(data)
	self._themePostMo = data

	local postCo = self._themePostMo:getThemePostCo()
	local playerCo = self._themePostMo:getPlayerCo()
	local isIn = AirtightRoomController.instance:getIsInAirtightTime()

	self._txtName.text = playerCo.name
	self._txtContent.text = postCo.title
	self._txtTime.text = ControlActionUtil.getTimeStr(self._themePostMo:getTime())
	self._txtLikeCount.text = self._themePostMo:getLikeCount()

	goutil.setActive(self._bgScretGo, self._themePostMo:isTop() and isIn)
	goutil.setActive(self._bgNormalGo, self._themePostMo:isTop() and not isIn)
	goutil.setActive(self._likeFlagGo, self._themePostMo:getLikeCount() > 0)
	goutil.setActive(self._unlikeFlagGo, self._themePostMo:getLikeCount() == 0)

	if self._themePostMo:isTop() and isIn then
		settimer(0.3, function()
			self._animation:Play("regulatory_forum_post_item_open")
		end, self, false)
	end
end

function M:OnDestroy()
	self:_unbindEvents()
end

return M
