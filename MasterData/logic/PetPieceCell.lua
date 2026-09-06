-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/material/proxy/pet/PetPieceCell.lua

module("logic.extensions.material.proxy.pet.PetPieceCell", package.seeall)

local PetPieceCell = class("PetPieceCell", MaterialCell)

function PetPieceCell:ctor(target)
	PetPieceCell.super.ctor(self, target)

	self.container = goutil.findChild(target.gameObject, "container")
	self.imgQua = goutil.findChildComponent(self.container, "imgQua", "UIImageSpriteChange")
	self.imgIcon = goutil.findChild(self.container, "imgIcon/con")
	self.imgRare = goutil.findChild(self.container, "imgRare")
	self.progress = goutil.findChild(self.container, "progress")

	if self.progress then
		self.imgProgress = goutil.findChildComponent(self.progress, "imgProgress", "Image")
		self.txtProgress = goutil.findChildComponent(self.progress, "txtProgress", "Text")
	end

	self.imgSelected = goutil.findChild(self.container, "selected")
	self._txtBg = goutil.findChild(self.container, "txtBg")
	self._txtNum = goutil.findChild(self.container, "txtNum"):GetComponent(goutil.Type_UIText)
end

function PetPieceCell:setCfgData(data)
	PetPieceCell.super.setCfgData(self, data)
	GameUtil.addClickHandler(self.container, self._OnClick, self)

	local rare = CharacterConfig.instance:getRareByAwakenLv(data.initAwakenLv, data.raceId)

	self.imgQua:SetState(rare + 1)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(data.faceIds))

	uGuiUtil.setSpriteToImage(self.imgIcon.gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

	local curPieceNum = MaterialFacade.instance:getMatNumber(MatType.PetPiece, data.raceId)
	local needPieceNum = checknumber(data.needPieceNum)

	if self.imgProgress then
		if needPieceNum > 0 then
			self.imgProgress.fillAmount = curPieceNum / needPieceNum or 0
		end
	end

	if self.txtProgress then
		self.txtProgress.text = string.format("<size=18>%s/</size>%s", curPieceNum, needPieceNum)
	end

	self:setNum(curPieceNum)
end

function PetPieceCell:_OnClick()
	print(">>>>>>>>>>> click PetPieceCell")

	if self.autoTips then
		CommonTipsMgr.instance:openMaterialTips(self.imgIcon, self.type, self.id, self.num)
	end

	GameUtil.callBack(self.callback)
end

function PetPieceCell:setSelected(isSelected)
	GameUtil.SetActive(self.imgSelected, isSelected)
end

function PetPieceCell:setNum(num)
	if num == 0 then
		self._txtBg:SetActive(false)
		self._txtNum.gameObject:SetActive(false)
	else
		self._txtBg:SetActive(true)
		self._txtNum.gameObject:SetActive(true)

		self._txtNum.text = num
	end
end

function PetPieceCell:dispose()
	PetPieceCell.super.dispose(self)
	self:setSelected(false)
	MaterialMgr.resetAll(self.imgRare)
	MaterialMgr.clearIcon(self.imgIcon.gameObject)
	GameUtil.rmClickHandler(self.container)
end

return PetPieceCell
