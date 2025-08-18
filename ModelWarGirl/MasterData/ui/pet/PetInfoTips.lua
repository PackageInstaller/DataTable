-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetInfoTips.lua

local EventConst = require("EventConst")
local ModelTool = require("Entity/ModelTool")
local ModelFactory = Framework.Entity.ModelFactory
local PetInfoTipsInfoPanel = require("UI/Pet/PetTipsInfoPanel")
local ResPetStar = require("ClientData/ResPetStar")
local strClassName = "PetInfoTips"
local PetInfoTips = Class(strClassName, UIControls.Window)

function PetInfoTips:ctor()
	self._slot4LoadNewModelEnd = Slot(self.initModelLoadedEnd, self)

	self:initUI()
end

function PetInfoTips:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnChange2D = UIControls.Button(self, "BtnChange2D")

	self.btnChange2D:addEventClick(self.onBtnChange2DClick)

	self.imgChange = UIControls.Image(self, "BtnChange2D/ImgChange")
	self.txtChange = UIControls.Label(self, "BtnChange2D/TxtChange")
	self.btnPetLast = UIControls.Button(self, "BtnPetLast")

	self.btnPetLast:addEventClick(self.onBtnPetLastClick)

	self.btnPetNext = UIControls.Button(self, "BtnPetNext")

	self.btnPetNext:addEventClick(self.onBtnPetNextClick)

	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.modelStage = ModelStageManager.createUIModelStage(self, "ModelStage/NewPetDlgModelStage_03")
	self.modelControl = UIControls.Panel(self, "ModelControl")
	self.imgIconPortrait = UIControls.Image(self, "MainInfoPanel/ListFunPanel/BtnPortrait/Image")

	self.modelStage:initOperation(self.modelControl)

	self.modelStage.mEventOprFingerDown = Slot(self.onDragStart, self)
	self.modelStage.mEventOprFingerUp = Slot(self.onDragEnd, self)
	self.paintingPanel = UIControls.Panel(self, "PaintingPanel")
	self.petRolePortrait = UIControls.PetRole(self, "PaintingPanel", 0, 0)
	self.petInfoTipsInfoPanel = PetInfoTipsInfoPanel(self, "PetInfoPanel")
	self.petGemPanel = UIControls.Panel(self, "PetGemPanel")

	self.petGemPanel:setVisible(CurAvatar:petGemSystemEnable())

	self.gemPanel = {}

	for i = 1, Const.PET_GEM_MAX_NUM do
		local btnGem = UIControls.Button(self, "PetGemPanel/Gem0" .. i)

		btnGem:addEventClick(Functor(self.onGemClick, self, i))

		local iconNew = UIControls.Image(self, "PetGemPanel/Gem0" .. i .. "/IconNew")

		table.insert(self.gemPanel, {
			btnGem = btnGem,
			iconNew = iconNew
		})
	end

	self.gemCells = {}
	self.btnGemTips = UIControls.Button(self, "PetGemPanel/BgTide2/BtnTips")

	self.btnGemTips:addEventClick(self.onBtnGemTipsClick)

	self.gemTipsPanel = UIControls.Panel(self, "GemTipsPanel")
	self.uIClickThrough = UIControls.Button(self, "GemTipsPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.slotOnPetGemChange = Slot(self.onPetGemChange, self)

	EventCenter.addEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
end

function PetInfoTips:onOpen()
	PetInfoTips.super.onOpen(self)
	self.modelStage:connectImage(self.modelViewport)
end

function PetInfoTips:destroy()
	EventCenter.removeEventListener(EventConst.PET_GEM_CHANGE, self.slotOnPetGemChange)
	PetInfoTips.super.destroy(self)
end

function PetInfoTips:_setObj(pet, selectIndex)
	self.pet = pet

	if selectIndex then
		self.selectIndex = selectIndex
	end

	self.allPetList = CurAvatar:getAllSortedPets()

	self.btnPetLast:setVisible(self.selectIndex and self.selectIndex ~= 1)
	self.btnPetNext:setVisible(self.selectIndex and self.selectIndex ~= #self.allPetList)
	self.petInfoTipsInfoPanel:setPet(self.pet)
	self.paintingPanel:setVisible(not self.modelControl:getVisible())
	self:refreshModel()
	self:refreshGemInfo()
	BeginnerManager.CheckPetCanWearGem(self.pet.id)
end

function PetInfoTips:refreshGemInfo()
	if CurAvatar:petGemSystemEnable() then
		self.petGemList = self.pet:getBattlePetGem()
		self.gemNum = ResPetStar[self.pet.star].gem_num

		for i = 1, Const.PET_GEM_MAX_NUM do
			if i <= self.gemNum then
				self.gemPanel[i].btnGem:setVisible(true)

				if self.petGemList[i] then
					local gemCell = self.gemCells[i]

					if gemCell == nil then
						gemCell = UIControls.GridPetGemChild(self, "PetGemPanel/Gem0" .. i, "System/Pet/GridPetGemMini", 0, 0, true)
					end

					gemCell:setObj(self.petGemList[i])

					gemCell.mEventClick = Slot(self.onGemGridClick, self)
					self.gemCells[i] = gemCell
				elseif self.gemCells[i] then
					self.gemCells[i]:destroy()

					self.gemCells[i] = nil
				end

				self.gemPanel[i].iconNew:setVisible(self.petGemList[i] == nil and CurAvatar:checkIsHasGemNotWearing() or self.petGemList[i] and self.petGemList[i]:checkHasHigherLvGemNotWearing())
			else
				self.gemPanel[i].btnGem:setVisible(false)

				if self.gemCells[i] then
					self.gemCells[i]:destroy()

					self.gemCells[i] = nil
				end
			end
		end
	end
end

function PetInfoTips:refreshModel()
	if self.curModelInsId then
		self.autoRotateComponent = nil

		self.modelStage:delModel(self.curModelInsId)
	end

	local modelId = self.pet:getShowModelId()
	local baseModelId = self.pet:getShowBaseModelId()

	self.petRolePortrait:showRole(self.pet.id)

	self.curModelInsId = self.modelStage:showHeroByModId(modelId, Const.MODEL_TYPE.ShowStepOne, nil, self._slot4LoadNewModelEnd, nil, baseModelId)

	if self.curModelInsId then
		self.modelStage:setOperateModel(self.curModelInsId)
	end

	self:hideModel(not self.modelControl:getVisible())
end

function PetInfoTips:initModelLoadedEnd(modelInsId, baseModelId)
	self.autoRotateComponent = ModelTool.addAutoRotateComponent(modelInsId)

	if baseModelId then
		ModelTool.addBaseModel(modelInsId, baseModelId, 1, Const.HERO_BASE_TYPE.Hero1)
	end

	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:SetAnimatorNoCulling()
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function PetInfoTips:playShowAnimation(modelInsId)
	if modelInsId then
		local modelAux = ModelFactory.GetModelAux(modelInsId)

		if modelAux then
			modelAux:PlayAnimatorNow("Newshow_idle")
		end
	end
end

function PetInfoTips:onBtnChange2DClick()
	local txtChange = self.modelControl:getVisible() and Lang.get(30236) or Lang.get(958)
	local imgChange = self.modelControl:getVisible() and "BgModel" or "BgDraw"

	self.imgChange:setImage("Atlas/PetAtlas/PetInfoAtlas", imgChange)
	self.txtChange:setText(txtChange)
	self.modelControl:changeVisible()
	self.paintingPanel:setVisible(not self.modelControl:getVisible())
	self:hideModel(not self.modelControl:getVisible())
end

function PetInfoTips:hideModel(isHide, ignoreAnim)
	self.modelControl:setVisible(not isHide)
	self.modelStage:setModelVisible(self.curModelInsId, not isHide)

	if not isHide and not ignoreAnim then
		self:playShowAnimation(self.curModelInsId)
	end
end

function PetInfoTips:onDragStart()
	if self.autoRotateComponent then
		self.autoRotateComponent:EndRotate()
	end
end

function PetInfoTips:onDragEnd()
	if self.autoRotateComponent then
		self.autoRotateComponent:StartRotate()
	end
end

function PetInfoTips:onBtnPetLastClick()
	if self.selectIndex and self.selectIndex > 1 then
		local selectIndex = self.selectIndex - 1

		self:_setObj(self.allPetList[selectIndex], selectIndex)
	end
end

function PetInfoTips:onBtnPetNextClick()
	if self.selectIndex and self.selectIndex < #self.allPetList then
		local selectIndex = self.selectIndex + 1

		self:_setObj(self.allPetList[selectIndex], selectIndex)
	end
end

function PetInfoTips:refreshUI()
	self.pet = CurAvatar.petDic[self.pet.id]

	self:refreshModel()
	self:refreshInfoUI()
	self:refreshGemInfo()
end

function PetInfoTips:refreshInfoUI()
	self.petInfoTipsInfoPanel:setPet(self.pet)
end

function PetInfoTips:onPetGemChange()
	self:refreshGemInfo()
	self.petInfoTipsInfoPanel:refreshAttrPanel()
	self.petInfoTipsInfoPanel:refreshStartPanel()
end

function PetInfoTips:onGemClick(index)
	if not self.petGemList[index] then
		UIManager.getUI("petGemWearDlg", true):setData(nil, self.pet.id)
	end
end

function PetInfoTips:onGemGridClick(sender)
	local mTipsConfig = CurAvatar.commonGemTipsFuncItem

	UIManager.getUI("petGemTips"):show(sender, mTipsConfig, nil, nil, {
		checkShowPetGemChange = true
	})
end

function PetInfoTips:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_MAIN)
end

function PetInfoTips:onBtnGemTipsClick()
	self.gemTipsPanel:setVisible(true)
end

function PetInfoTips:onUIClickThroughClick()
	self.gemTipsPanel:setVisible(false)
end

function PetInfoTips:onBtnCloseClick()
	self:setVisible(false)
end

return PetInfoTips
