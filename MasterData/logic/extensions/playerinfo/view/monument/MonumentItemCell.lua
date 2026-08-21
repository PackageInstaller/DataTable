-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/monument/MonumentItemCell.lua

module("logic.extensions.playerinfo.view.monument.MonumentItemCell", package.seeall)

local M = class("MonumentItemCell", ListBinderCell)

function M:ctor(compContainer)
	M.super.ctor(self, compContainer)

	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._canClick = true

	self:_buildUI()
end

function M:_buildUI()
	self._imgMonument = goutil.findChildImageComponent(self._mainGo, "imgSyndromeCard")
	self._txtName = goutil.findChildTextComponent(self._mainGo, "txtName")
	self._btnClick = Astral.ButtonAdapter.Get(goutil.findChild(self._mainGo, "click"))
	self._selectGo = goutil.findChild(self._mainGo, "select")
	self._ani = goutil.addComponentOnce(self._mainGo, ComponentType.Animation)
	self._redPoint = goutil.findChild(self._mainGo, "red_point")

	self:_bindEvents()
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_bindEvents()
	self._btnClick:AddClickListener(self._onClickSelf, self)
end

function M:_unbindEvents()
	self._btnClick:RemoveClickListener()
end

function M:_onClickSelf()
	if self._canClick then
		local index = MonumentModel.instance:getMonumentListModel():getMoIndex(self._data)

		if self._redPoint.activeSelf then
			RedDotAgent.instance:sendRemoveRedPointRequest(GameEnum.RedPointEnum.Cup, {
				self._data:getNo()
			})
		end

		GlobalDispatcher:dispatchEvent(EventType.PLAYER_MOUNMENT_REFRESH, index)
	end
end

function M:setCellIndex(cellIndex)
	M.super.setCellIndex(self, cellIndex)
end

function M:changeLeftRight()
	if self._redPoint.activeSelf then
		RedDotAgent.instance:sendRemoveRedPointRequest(GameEnum.RedPointEnum.Cup, {
			self._data:getNo()
		})
	end
end

function M:setHint(currLevel)
	local colorBgIndex = 1
	local code = self._data:getNo()
	local maxLevel = MonumentConfig.instance:maxGradeUpLevel(code)
	local hintStr = lang("tip_monument_low")

	if currLevel == maxLevel and maxLevel ~= 1 then
		hintStr = lang("tip_monument_high")
		colorBgIndex = 3
	elseif currLevel > 1 then
		hintStr = lang("tip_monument_middle")
		colorBgIndex = 2
	end
end

function M:updateData(data, needPre, curSelect)
	self:_setData(data)
	self:setPreStatus(needPre)

	local index = MonumentModel.instance:getMonumentListModel():getMoIndex(self._data)

	goutil.setActive(self._selectGo, curSelect == index)

	local maxLv = MonumentModel.instance:getMaxLevel(self._data:getNo())
	local material = self._imgMonument.material

	if MonumentUtil.isLoaded() then
		if maxLv == self._data:getLv() then
			material = MonumentUtil.getMaterial(3)
		elseif self._data:getLv() == 1 then
			material = MonumentUtil.getMaterial(1)
		else
			material = MonumentUtil.getMaterial(2)
		end
	end

	self._imgMonument.material = material

	local redKey = string.format("%d_%d", GameEnum.RedPointEnum.Cup, self._data:getNo())

	self._redBeh = RedDotModel.instance:createDotView({
		dotNode = self._redPoint,
		keyList = {
			redKey
		}
	})

	if curSelect == index and index == 1 then
		self:changeLeftRight()
		goutil.setActive(self._redPoint, false)
	end
end

function M:_setData(data)
	self._data = data

	self:setHint(data:getLv())

	local code = data:getNo()
	local maxLevel = MonumentConfig.instance:maxGradeUpLevel(code)

	self._txtName.text = data:getName()

	IconLoader.setSprite(self._imgMonument, IconType.Monument, data:getStyle())
end

function M:playAni(data, name)
	self:_setData(data)
	self._ani:Stop()
	self._ani:Play(name)
end

function M:playAutomatically(isAutomatic)
	self._ani.playAutomatically = isAutomatic
end

function M:setPreStatus(isPre)
	if isPre then
		self:setHint(self._data:getLv() - 1)
	else
		self:setHint(self._data:getLv())
	end
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_destroyUI()
	self:_unbindEvents()
end

function M:setCanClick(canClick)
	self._canClick = canClick
end

function M:deleteRedPoint()
	RedDotModel.instance:deleteDotView(self._redBeh)
end

function M:setNameVisible(visible)
	self._txtName.gameObject:SetActive(visible)
end

function M:showRedPoint(isShow)
	goutil.setActive(self._redPoint, isShow)
end

return M
