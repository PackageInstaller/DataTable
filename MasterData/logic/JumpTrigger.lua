-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpTrigger.lua

module("logic.extensions.jumpgame.view.JumpTrigger", package.seeall)

local JumpTrigger = class("JumpTrigger")

function JumpTrigger.AddOnce(go)
	local component = JumpTrigger.Get(go)

	component = component or Framework.LuaComponentContainer.Add(go, JumpTrigger)

	return component
end

function JumpTrigger.Remove(go)
	local sender = JumpTrigger.Get(go)

	GlobalDispatcher:removeListener(GlobalNotify.JumpPlayerPos, sender._onPlayerPosChange, sender)
	Framework.LuaComponentContainer.Remove(go, JumpTrigger)
end

function JumpTrigger.Get(go)
	return (Framework.LuaComponentContainer.Get(go, JumpTrigger))
end

function JumpTrigger:ctor(container)
	self._container = container.gameObject
	self._item = nil
	self._len = 100

	GlobalDispatcher:addListener(GlobalNotify.JumpPlayerPos, self._onPlayerPosChange, self)
end

function JumpTrigger:setResInstance(instance)
	self._resInstance = instance
end

function JumpTrigger:initPillarMo(mo)
	self._pillarMo = mo
end

function JumpTrigger:OnDestroy()
	GlobalDispatcher:removeListener(GlobalNotify.JumpPlayerPos, self._onPlayerPosChange, self)
end

function JumpTrigger:OnTriggerEnter()
	return
end

function JumpTrigger:_onPlayerPosChange(player)
	if goutil.isNil(self._container) then
		GlobalDispatcher:removeListener(GlobalNotify.JumpPlayerPos, self._onPlayerPosChange, self)

		return
	end

	local rectTransform = self._container:GetComponent("RectTransform")
	local playerMaxPos = player.transform.parent.transform:TransformPoint(player.transform.localPosition.x + 20, player.transform.localPosition.y, 0)
	local playerMinPos = player.transform.parent.transform:TransformPoint(player.transform.localPosition.x - 20, player.transform.localPosition.y, 0)
	local maxLocalPos = Vector3.New(self._container.transform.localPosition.x + self._len, self._container.transform.localPosition.y + rectTransform.rect.height, 0)
	local maxPos = self._container.transform.parent.transform:TransformPoint(maxLocalPos)

	if playerMinPos.x > maxPos.x then
		return nil
	end

	if self._container.transform.position.x < playerMinPos.x and playerMinPos.x < maxPos.x and self._container.transform.position.y < playerMinPos.y and playerMinPos.y < maxPos.y then
		if self._container.transform.position.x < player.transform.position.x and player.transform.position.x < maxPos.x and player.transform.position.y < maxPos.y then
			local param = {}

			param[1] = maxPos
			param[2] = true

			GlobalDispatcher:dispatch(GlobalNotify.JumpPlayerStop, param)
			self:_onCheckScore(player)
		else
			local param = {}

			param[1] = player.transform.position
			param[2] = false
			param[3] = -45

			GlobalDispatcher:dispatch(GlobalNotify.JumpPlayerStop, param)
		end

		return
	end

	if self._container.transform.position.x < playerMaxPos.x and playerMaxPos.x < maxPos.x and self._container.transform.position.y < playerMaxPos.y and playerMaxPos.y < maxPos.y then
		if self._container.transform.position.x < player.transform.position.x and player.transform.position.x < maxPos.x and player.transform.position.y < maxPos.y then
			local param = {}

			param[1] = maxPos
			param[2] = true

			GlobalDispatcher:dispatch(GlobalNotify.JumpPlayerStop, param)
			self:_onCheckScore(player)
		else
			local param = {}

			param[1] = player.transform.position
			param[2] = false
			param[3] = 45

			GlobalDispatcher:dispatch(GlobalNotify.JumpPlayerStop, param)
		end
	end
end

function JumpTrigger:_onCheckScore(player)
	local playerPos = player.transform.parent.transform:TransformPoint(player.transform.localPosition.x, player.transform.localPosition.y, 0)

	if not self._pillarViews then
		return
	end

	for i = 1, #self._pillarViews do
		local maxLocalPos = Vector3.New(self._pillarViews[i].transform.localPosition.x + 146, self._pillarViews[i].transform.localPosition.y, 0)
		local maxPos = self._pillarViews[i].transform.parent.transform:TransformPoint(maxLocalPos)

		if self._pillarViews[i].transform.position.x <= playerPos.x and playerPos.x <= maxPos.x then
			self:_setItemVisible(i)
		end
	end
end

function JumpTrigger:_onCheckBack()
	return
end

function JumpTrigger:initPillars()
	self._pillarViews = {}
	self._len = 0

	for i = 1, self._pillarMo._pillars.pillars do
		self._pillarViews[i] = self._resInstance:getResInstance("ui/views/jumpgame/pillar.prefab")
		self._pillarViews[i].gameObject.transform.localPosition = Vector3.New(self._len, 0, 0)

		local ramdomNumber = Mathf.Floor(UnityEngine.Random.Range(0.01, 1.9))

		for j = 0, 1 do
			local obj = self._pillarViews[i]

			obj.transform:GetChild(j).gameObject:SetActive(j == ramdomNumber)
		end

		JumpGameModel.instance:AddPlateFormLen(146)

		self._len = self._len + 146

		goutil.addChildToParent(self._pillarViews[i], self._container)
	end
end

function JumpTrigger:initItem(itemMo, gameType)
	local offset_x = 0

	self._item = {}

	if itemMo then
		for i = 1, #itemMo do
			if itemMo[i] then
				self._item[i] = self._resInstance:getResInstance(string.format("ui/views/jumpgame/item%d.prefab", itemMo[i]._itemType))
				self._item[i].gameObject.transform.localPosition = Vector3.New(offset_x, 145, 0)

				self._item[i].gameObject:GetComponent("UIImageSpriteChange"):ChangeStateNow(gameType - 1)

				local item = JumpGameItem.AddOnce(self._item[i])

				item:initItem(itemMo[i])
				goutil.addChildToParent(self._item[i].gameObject, self._container)
			end

			offset_x = offset_x + 146
		end
	end
end

function JumpTrigger:_setItemVisible(idx)
	if self._item and self._item[idx] then
		if JumpGameItem.AddOnce(self._item[idx].gameObject):returnGetTag() == false then
			JumpGameModel.instance:addCollect(JumpGameItem.AddOnce(self._item[idx].gameObject):getItem()._itemType)
			GlobalDispatcher:dispatch(GlobalNotify.JumpItemVisible)
		end

		for i = 1, #self._item do
			if self._item[i] then
				JumpGameItem.AddOnce(self._item[i].gameObject):hasGet()
				self._item[i].gameObject:SetActive(false)
			end
		end
	end
end

return JumpTrigger
