-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/filter/PetSortPane.lua

module("logic.extensions.bag.view.filter.PetSortPane", package.seeall)

local PetSortPane = class("PetSortPane")

function PetSortPane:ctor(target)
	self._go = target.gameObject
	self._filterGo = self._go
	self._customInput = UICustomInput.Get(self._filterGo)
	self._sortGoList = {}

	GameUtil.SetActive(self._filterGo, false)
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function PetSortPane:reset(arr)
	for i, v in ipairs(arr) do
		local go = goutil.findChild(self._filterGo, "Cell" .. i)

		if go then
			self._sortGoList[i] = go

			local ImgSort = goutil.findChild(go, "ImgSort"):GetComponent("UIImageSpriteChange")

			ImgSort:SetState(v)
			GameUtil.addClickHandler(go, GameUtil.handler(self._onClickFilterBtn, self, go, i))
		end
	end
end

function PetSortPane:init(func, tar)
	self._callback = func
	self._callbackTar = tar
end

function PetSortPane:OnDestroy()
	self._customInput:RemoveListener()

	for i = 1, #self._sortGoList do
		local go = self._sortGoList[i]

		GameUtil.rmClickHandler(go)
	end
end

function PetSortPane:_onClickFilterBtn(go, idx)
	GameUtil.callBack(self._callback, self._callbackTar, idx)
end

function PetSortPane:_onCustomInputCallback(hover)
	if not hover then
		GameUtil.SetActive(self._filterGo, false)
	end
end

function PetSortPane:show()
	GameUtil.SetActive(self._filterGo, true)
end

return PetSortPane
