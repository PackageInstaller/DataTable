-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/shenyaolongzunshengzhu/view/ShenyaolongzunshengzhuresultView.lua

module("logic.extensions.shenyaolongzunshengzhu.view.ShenyaolongzunshengzhuresultView", package.seeall)

local ShenyaolongzunshengzhuresultView = class("ShenyaolongzunshengzhuresultView", ViewComponent)

function ShenyaolongzunshengzhuresultView:ctor()
	ShenyaolongzunshengzhuresultView.super.ctor(self)
end

function ShenyaolongzunshengzhuresultView:unbindEvents()
	ShenyaolongzunshengzhuresultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function ShenyaolongzunshengzhuresultView:bindEvents()
	ShenyaolongzunshengzhuresultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function ShenyaolongzunshengzhuresultView:buildUI()
	ShenyaolongzunshengzhuresultView.super.buildUI(self)

	self._btnSure = self:getGo("btnSure")
	self._lastContainer = self:getGo("last/container")
	self._container = self:getGo("bottom/container")
	self._lastEmpty = self:getGo("last/empty")
	self._empty = self:getGo("bottom/empty")
	self._item = self:getGo("item")

	GameUtil.SetActive(self._item, false)
end

function ShenyaolongzunshengzhuresultView:onExit()
	ShenyaolongzunshengzhuresultView.super.onExit(self)
end

function ShenyaolongzunshengzhuresultView:onEnter()
	ShenyaolongzunshengzhuresultView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = params[1]

	if not params[2] then
		local lastList = {}

		if not params[3] then
			local curList = {}

			GameUtil.SetActive(self._lastEmpty, #lastList == 0)
			goutil.clearChildren(self._lastContainer)

			for i, v in ipairs(lastList) do
				local item = goutil.cloneAndSetParent(self._item, self._lastContainer.transform, "cell_" .. i)

				GameUtil.SetActive(item, true)

				local img = goutil.findChild(item, "img")

				GameUtil.setUIImageSpriteIdx(img, v.id - 1)

				for j = 1, 6 do
					local go = goutil.findChild(item, "txt_" .. j)

					GameUtil.SetActive(go, v.id == j)
				end

				local txtNum = goutil.findChildTextComponent(item, "txtNum")

				txtNum.text = v.num
			end

			GameUtil.SetActive(self._empty, #curList == 0)
			goutil.clearChildren(self._container)

			for i, v in ipairs(curList) do
				local item = goutil.cloneAndSetParent(self._item, self._container.transform, "cell_" .. i)

				GameUtil.SetActive(item, true)

				local img = goutil.findChild(item, "img")

				GameUtil.setUIImageSpriteIdx(img, v.id - 1)

				for j = 1, 6 do
					local go = goutil.findChild(item, "txt_" .. j)

					GameUtil.SetActive(go, v.id == j)
				end

				local txtNum = goutil.findChildTextComponent(item, "txtNum")

				txtNum.text = v.num
			end
		end
	end
end

function ShenyaolongzunshengzhuresultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return ShenyaolongzunshengzhuresultView
