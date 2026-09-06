-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jackpot/view/JackpotItem.lua

module("logic.extensions.jackpot.view.JackpotItem", package.seeall)

local JackpotItem = class("JackpotItem")

function JackpotItem:ctor(go)
	self.mainGO = go

	self:buildUI()
	self:onEnter()
end

function JackpotItem:OnDestroy()
	self:onExit()
end

function JackpotItem:buildUI()
	self.yhdGo = goutil.findChild(self.mainGO, "yhd")
	self.imageSpriteChange = goutil.findChild(self.mainGO, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	self.bgBtn = GameUtil.asBtn(self.imageSpriteChange.gameObject)
	self.icon = goutil.findChild(self.mainGO, "icon")
	self.numText = goutil.findChildTextComponent(self.mainGO, "icon/numText")
	self.tagImg = goutil.findChild(self.mainGO, "tag")

	if self.flagCache ~= nil then
		self:setSelect(self.flagCache)
	end
end

function JackpotItem:onEnter()
	self.bgBtn:AddClickListener(self._onClickBg, self)
end

function JackpotItem:onExit()
	MaterialMgr.clearIcon(self.icon)
	self.bgBtn:RemoveClickListener()
end

function JackpotItem:_onClickBg()
	if self.cfg then
		local str = MaterialMgr.changeItemStr(self.cfg.reward)
		local temp = string.split(str, "#")
		local list = string.split(temp[1], ":")

		CommonTipsMgr.instance:openMaterialTips(self.mainGO, checknumber(list[1]), checknumber(list[2]), 0)
	end
end

function JackpotItem:setData(cfg, isget, index)
	self.cfg = cfg
	self.index = index

	self:setSelect(false)

	local arr = string.split(cfg.reward, ":")
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

function JackpotItem:setSelect(flag)
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

function JackpotItem:getSelect()
	return self._isSelected or false
end

return JackpotItem
