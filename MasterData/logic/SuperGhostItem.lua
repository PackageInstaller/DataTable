-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/superghostlottery/view/SuperGhostItem.lua

module("logic.extensions.superghostlottery.view.SuperGhostItem", package.seeall)

local SuperGhostItem = class("SuperGhostItem")

function SuperGhostItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function SuperGhostItem:OnDestroy()
	self:onExit()
end

function SuperGhostItem:buildUI()
	self.yhdGo = goutil.findChild(self.mainGO, "yhd")
	self.imageSpriteChange = goutil.findChild(self.mainGO, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self.bgBtn = GameUtil.asBtn(self.imageSpriteChange.gameObject)
	self.icon = goutil.findChild(self.mainGO, "icon")
	self.numText = goutil.findChildTextComponent(self.mainGO, "icon/numText")
	self.tagImg = goutil.findChild(self.mainGO, "tag")
	self.imgAdd = goutil.findChild(self.mainGO, "imgAdd")

	if self.flagCache ~= nil then
		self:setSelect(self.flagCache)
	end
end

function SuperGhostItem:onEnter()
	self.bgBtn:AddClickListener(self._onClickBg, self)
end

function SuperGhostItem:onExit()
	MaterialMgr.clearIcon(self.icon)
	self.bgBtn:RemoveClickListener()
end

function SuperGhostItem:_onClickBg()
	if self.reward.data then
		local str = MaterialMgr.changeItemStr(self.reward.data.prize)
		local temp = string.split(str, "#")
		local list = string.split(temp[1], ":")

		CommonTipsMgr.instance:openMaterialTips(self.mainGO, checknumber(list[1]), checknumber(list[2]), 0)
	elseif self.reward.isEmpty == true then
		GlobalDispatcher:dispatch(GlobalNotify.SuperGhostLotteryEmptyItemClick)
	end
end

function SuperGhostItem:setData(reward, isget, index)
	self.reward = reward
	self.index = index

	self:setSelect(false)

	if self.reward.isEmpty == true then
		MaterialMgr.clearIcon(self.icon)
		GameUtil.SetActive(self.yhdGo, false)
		GameUtil.SetActive(self.tagImg, false)
		GameUtil.SetActive(self.numText, false)
		GameUtil.SetActive(self.imgAdd, true)
	elseif self.reward.isNotDifine == true then
		MaterialMgr.clearIcon(self.icon)
		GameUtil.SetActive(self.imgAdd, false)
		GameUtil.SetActive(self.tagImg, false)

		self.numText.text = "未定义"

		GameUtil.SetActive(self.yhdGo, true)
	else
		GameUtil.SetActive(self.imgAdd, false)
		GameUtil.SetActive(self.numText, true)

		local arr = string.split(reward.data.prize, ":")
		local matType = checknumber(arr[1])
		local matId = checknumber(arr[2])

		self.numText.text = checknumber(arr[3])
		self.matType = matType
		self.matId = matId

		MaterialMgr.setIcon(self.icon, matType, matId)
		GameUtil.SetActive(self.yhdGo, isget)

		if isget then
			self:setSelect(false)
		end

		local mcfg = MaterialMgr.getMatCfg(matType, matId)

		GameUtil.SetActive(self.tagImg, mcfg and mcfg.subType == MatType.Item_Piece)
	end
end

function SuperGhostItem:setSelect(flag)
	if not self.imageSpriteChange then
		self.flagCache = flag

		return
	end

	self.flagCache = nil

	if flag then
		AudioPlayerEx.instance:playEffect(30217)
		self.imageSpriteChange:SetState(2)

		self._isSelected = true
	elseif self.index == 2 or self.index == 5 or self.index == 8 or self.index == 11 then
		self.imageSpriteChange:SetState(1)

		self._isSelected = false
	else
		self.imageSpriteChange:SetState(0)

		self._isSelected = false
	end
end

function SuperGhostItem:getSelect()
	return self._isSelected or false
end

return SuperGhostItem
