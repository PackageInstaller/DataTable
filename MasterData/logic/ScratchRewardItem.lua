-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchRewardItem.lua

module("logic.extensions.scratch.view.ScratchRewardItem", package.seeall)

local ScratchRewardItem = class("ScratchRewardItem")

function ScratchRewardItem:ctor(luaComponentContainer)
	local go = luaComponentContainer.gameObject

	self._node = goutil.findChild(go, "node"):GetComponent(goutil.Type_RectTransform)
	self._select = goutil.findChild(go, "select")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "btnClick")

	goutil.setActive(self._select, false)
end

function ScratchRewardItem:init(index, data)
	self._btnClick:AddClickListener(self._onBtnClick, self)

	self._data = data
	self._index = index
	self._id = data.id
	self._rewardType = data.rewardType

	MaterialMgr.setCellByCfg(data.prize, self._node)
	goutil.setActive(self._select, data.isSelect)
end

function ScratchRewardItem:reset()
	MaterialMgr.resetAll(self._node)
	self._btnClick:RemoveClickListener()
end

function ScratchRewardItem:_onBtnClick()
	if self._select.activeSelf then
		ScratchModel.instance:removeSelectReward(self._rewardType, self._id)
		goutil.setActive(self._select, false)

		self._data.isSelect = false
	else
		if ScratchModel.instance:isSelectMaxNum(self._rewardType) then
			GlobalDispatcher:dispatch(GlobalNotify.ScratchRemoveSelect, self._rewardType)
		end

		goutil.setActive(self._select, true)

		self._data.isSelect = true

		ScratchModel.instance:addSelectReward(self._rewardType, self._id)
	end
end

function ScratchRewardItem:cancelSelect()
	goutil.setActive(self._select, false)

	self._data.isSelect = false
end

return ScratchRewardItem
