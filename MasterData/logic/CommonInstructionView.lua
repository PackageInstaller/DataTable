-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/instruction/view/CommonInstructionView.lua

module("logic.extensions.common.instruction.view.CommonInstructionView", package.seeall)

local CommonInstructionView = class("CommonInstructionView", TipsViewBase)

function CommonInstructionView:ctor()
	CommonInstructionView.super.ctor(self)
end

function CommonInstructionView:buildUI()
	CommonInstructionView.super.buildUI(self)

	self._Nego_Content = goutil.findChild(self.mainGO, "Nego_Content")
	self._adjustPosition = self._Nego_Content:GetComponent("UIAdjustPosition")
	self._customInput = UICustomInput.Get(self._Nego_Content)

	local _Nego_Top = goutil.findChild(self._Nego_Content, "Nego_Top")

	self._TxtC_Name = goutil.findChild(_Nego_Top, "TxtC_Name"):GetComponent("Text")
	self._TxtC_Count = goutil.findChild(_Nego_Top, "TxtC_Count"):GetComponent("Text")
	self._ImgC_Con = goutil.findChild(_Nego_Top, "ImgC_Con")

	local _Nego_Bottom = goutil.findChild(self._Nego_Content, "Nego_Bottom")
	local viewGo = goutil.findChild(self._Nego_Content, "Nego_Bottom/view")

	self._layoutScrollRect = viewGo.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self._layoutElement = viewGo.gameObject:GetComponent(typeof(UnityEngine.UI.LayoutElement))
	self._TxtC_Desc_1 = MaterialMgr.findGraphicText(_Nego_Bottom, "view/TxtC_Desc_1")
	self._ImgC_Line = goutil.findChild(_Nego_Bottom, "ImgC_Line")
	self._TxtC_Desc_2 = goutil.findChild(_Nego_Bottom, "TxtC_Desc_2"):GetComponent("Text")
	self.imgBg = goutil.findChildComponent(_Nego_Top, "ImgC_TxtBg", "UIChangeGroup")
end

function CommonInstructionView:destroyUI()
	CommonInstructionView.super.destroyUI(self)
end

function CommonInstructionView:bindEvents()
	self._customInput:AddListener(self._onCustomInputCallback, self)
end

function CommonInstructionView:unbindEvents()
	self._customInput:RemoveListener()
end

function CommonInstructionView:_onCustomInputCallback(hover)
	CommonTipsMgr.instance:doWillClose(self, hover)
end

function CommonInstructionView:onEnter()
	CommonInstructionView.super.onEnter(self)

	local pos = self._viewPresentor._openParam[2]

	if not self._viewPresentor._openParam[3] then
		local sizeDelta = {
			0,
			0
		}
		local data = self._viewPresentor._openParam[1]

		MaterialMgr.resetAll(self._ImgC_Con)
		self.imgBg:SetState(0)
		GameUtil.SetActive(self._TxtC_Count, true)
		self:updateNum("")
		self:_SetName("")
		self:_SetDesc1("")
		self:_SetDesc2("")

		if data.type == MatType.Item or data.type == MatType.Coin or data.type == MatType.Diamond or data.type == MatType.Item_Fake or data.type == MatType.Strength or data.type == MatType.ACTIVITY_ITEM or data.type == MatType.Throne or data.type == MatType.Hoshigami or data.type == MatType.Hoshigami or data.type == MatType.StarGodPlus or data.type == MatType.TimedItem or data.type == MatType.HeadIcon or data.type == MatType.HeadFrame or data.type == MatType.Cloth or data.type == MatType.Equipment or data.type == MatType.Decoration or data.type == MatType.ACTIVITY_ENERGY or data.type == MatType.GodGem or data.type == MatType.ExpirableItem then
			self:setItemView(data)
		elseif data.type == MatType.Skill then
			self:setSkillView(data)
		elseif data.type == MatType.PokeBall then
			self:setPokeBallView(data)
		elseif data.type == MatType.Title then
			self:setTitleView(data)
		elseif data.type == MatType.PetPiece then
			self:setIcon(data)

			local cfg = MaterialMgr.getMatCfg(data.type, data.id)
			local nameText = MaterialMgr.getMaterialsName(data.type, data.id)

			self:_SetName(nameText)

			local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
			local numStr = string.format(lang("拥有 %s"), num)

			self:updateNum(numStr)

			local needPieceNum = checknumber(cfg.needPieceNum)
			local desc = langPara("tips_petpiece_compose", needPieceNum, cfg.name)

			self:_SetDesc1(desc)
		elseif data.type == MatType.Rune then
			self:setIcon(data)

			local cfg = MaterialMgr.getMatCfg(data.type, data.id)

			if cfg then
				local str = lang("类型：") .. RuneConfig.instance:getTypeName(cfg.runeType)

				self:updateNum(str)
				self.imgBg:SetState(cfg.quality or 0)
				self:_SetName(cfg.name)
				self:_SetDesc1(cfg.desc)
			end
		elseif data.type == MatType.Bubble then
			self:setIcon(data)

			local cfg = MaterialMgr.getMatCfg(data.type, data.id)

			if cfg then
				local numStr

				if cfg.defaultByVip then
					numStr = string.format(lang("拥有 %s"), RoleModel.instance:getVipLvl() < cfg.vipLevel and 0 or 1)
				else
					local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)

					numStr = string.format(lang("拥有 %s"), num)
				end

				self:updateNum(numStr)
				self:_SetName(cfg.bubbleName)
				self:_SetDesc1(cfg.desc)
			end
		elseif data.type == MatType.OpeningEffect then
			self:setOpeningEffectView(data)
		elseif data.type == MatType.HomePageBg then
			self:setHomePageBgView(data)
		elseif data.type == MatType.NameFrame then
			self:setNameFrameView(data)
		elseif data.type == MatType.PlayerMessageSkin then
			self:setPlayerMessageSkinView(data)
		elseif data.type == MatType.BattleUserInterfaceSkin or data.type == MatType.BattleBackgroundSkin then
			self:setBattleSkinView(data)
		elseif data.type == MatType.ImpressionSticker or data.type == MatType.ImpressionPoster then
			self:setImpressionStickerView(data)
		else
			self:setIcon(data)
			error("Tips 没有类型 Erorr:Unknown type:" .. data.type)
		end

		if pos then
			GameUtil.SetActive(self.mainGO, false)

			self._tempPos = pos
			self._tempSizeDelta = sizeDelta

			settimer(0.1, self._onTimer, self, false)
		else
			Framework.TransformUtil.SetLocalPos(self._Nego_Content.transform, 0, 0, 0)
		end
	end
end

function CommonInstructionView:_onTimer()
	local pos = self._tempPos
	local sizeDelta = self._tempSizeDelta

	GameUtil.SetActive(self.mainGO, true)
	Framework.TransformUtil.SetLocalScale(self.mainGO.transform, 1, 1, 1)
	self._adjustPosition:AdjustScreenPosition(pos, sizeDelta[1], sizeDelta[2])
end

function CommonInstructionView:setIcon(data)
	local proxy = MaterialMgr.setCell(data.type, data.id, self._ImgC_Con)

	if proxy then
		proxy:setAutoTips(false)
	end

	return proxy
end

function CommonInstructionView:setItemView(data)
	self:_SetDesc2(nil)

	local proxy = self:setIcon(data)
	local cfg = MaterialMgr.getMatCfg(data.type, data.id)

	if proxy then
		if data.extData1 ~= nil then
			proxy.binder:setNum(data.extData1)
		else
			proxy.binder:setNum(0)
		end
	end

	if not cfg then
		printError("cfg not found,type:" .. data.type .. ",id:" .. data.id .. ",找策划配表")

		return
	end

	if data.type ~= MatType.Equipment then
		if data.type == MatType.Decoration then
			self.imgBg:SetState(1 + (cfg.qualityBase or 0))
			proxy.binder:setLvl(checknumber(data.extData2))

			goto label_10_0
		end
	end

	self.imgBg:SetState(1 + (cfg.quality or 0))

	::label_10_0::

	local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)

	if data.type == MatType.Item_Fake then
		-- block empty
	elseif data.type == MatType.Diamond or data.type == MatType.PayDiamond then
		num = RoleModel.instance:getPayDiamond() + RoleModel.instance:getPresentDiamond()

		self:updateNum(string.format(lang("拥有 %s"), StringUtil.numberToString(num)))
	elseif data.type == MatType.Throne then
		-- block empty
	else
		local mountId = MountConfig.instance:getMountInMap(data.type, data.id)

		if mountId ~= nil and MountModel.instance:getLockmountsById(mountId) ~= false then
			self:updateNum(string.format(lang("拥有 %s"), StringUtil.numberToString(num + 1)))
		elseif num < 0 then
			self:updateNum(string.format(lang("拥有 <color=#c83c49>-%s</color>"), StringUtil.numberToString(math.abs(num))))
		else
			self:updateNum(string.format(lang("拥有 %s"), StringUtil.numberToString(num)))
		end
	end

	self:_SetName(cfg.name)

	local useCfg = MaterialConfig.instance:getCfgByMatAndId(data.type, data.id)

	if useCfg and useCfg.materialUseType == MatUseType.MIX_SELECT then
		local str = ""
		local content = useCfg.content
		local arr = string.split(content, ";")

		if #arr > 0 then
			local versionCode = checknumber(BootstrapUtil.getGameVersionCode())

			if (Framework.OSDef.RunOS == Framework.OSDef.Android and versionCode >= GameEnum.VERSION_ANDROID_20241017 or Framework.OSDef.RunOS == Framework.OSDef.IOS or Framework.OSDef.isEditor) and false then
				local temList = {}

				for i, v in ipairs(arr) do
					local type = MaterialMgr.getMatParams(v)

					if type == MatType.Pet then
						local matName = MaterialMgr.getMaterialsNameByCfg(v)

						table.insert(temList, matName)
					end
				end

				if #temList > 0 then
					str = lang("\n\n包含下列精灵：\n")
					str = str .. table.concat(temList, "，")
				end
			else
				local temList = {}

				for i, v in ipairs(arr) do
					local type = MaterialMgr.getMatParams(v)

					if type == MatType.Pet then
						local vv = MaterialMgr.getContentMatStr(v, 90, -10, MaterialMgr.ICON_TYPE_CFGID)

						table.insert(temList, vv)
					end
				end

				if #temList > 0 then
					str = lang("\n\n精灵预览：\n")
					str = str .. table.concat(temList, "")
				end
			end
		end

		self:_SetDesc1(cfg.desc .. str)
	else
		self:_SetDesc1(cfg.desc)
	end
end

function CommonInstructionView:setSkillView(data)
	local proxy = self:setIcon(data)
	local skillId = data.id
	local skillCo = BattleConfig.instance:getSkillCo(data.id)
	local type = GameEnum.SkillNameToType[skillCo.type]

	if data.extData2 then
		proxy.binder:SetSummonPetRaceId(data.extData2)
	end

	self:updateNum(MaterialMgr.getSkillTypeName(skillId))

	if skillCo ~= nil then
		self:_SetName(skillCo.name)

		local desc

		self:_SetDesc1(type == GameEnum.SkillRaceType.Summon and "" or skillCo.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setPokeBallView(data)
	local proxy = self:setIcon(data)
	local cfg = WeekRewardConfig.instance:getCfgById(data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum(numStr)
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setTitleView(data)
	local proxy = self:setIcon(data)
	local cfg = TitleConfig.instance:getCfgById(data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.titleName)
		self:_SetDesc1(cfg.titleDesc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setOpeningEffectView(data)
	local proxy = self:setIcon(data)
	local cfg = BattleStartAnimConfig.instance:getOpeningEffectCfg(data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setHomePageBgView(data)
	local proxy = self:setIcon(data)
	local cfg = BattleStartAnimConfig.instance:getHomePageBgCfg(data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setNameFrameView(data)
	local proxy = self:setIcon(data)
	local cfg = BattleStartAnimConfig.instance:getNameFrame(data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setPlayerMessageSkinView(data)
	local proxy = self:setIcon(data)
	local cfg = BattleStartAnimConfig.instance:getPlayerMessageSkinCfgById(data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setBattleSkinView(data)
	local proxy = self:setIcon(data)
	local cfg = MaterialMgr.getMatCfg(data.type, data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:setImpressionStickerView(data)
	local proxy = self:setIcon(data)
	local cfg = MaterialMgr.getMatCfg(data.type, data.id)

	if cfg then
		local num = MaterialModel.instance:getMaterialsNumber(data.type, data.id)
		local numStr = string.format(lang("拥有 %s"), num)

		self:updateNum("")
		self:_SetName(cfg.name)
		self:_SetDesc1(cfg.desc)
		self:_SetDesc2(nil)
	end
end

function CommonInstructionView:onExit()
	CommonInstructionView.super.onExit(self)
	removetimer(self.nextFrame, self)
	removetimer(self._onTimer, self)
end

function CommonInstructionView:onExitFinished()
	CommonInstructionView.super.onExitFinished(self)
end

function CommonInstructionView:_SetSkillIcon(name)
	self._ImgC_Icon:SetState(name)
end

function CommonInstructionView:_SetEquipIcon(name)
	return
end

function CommonInstructionView:_SetName(name)
	self._TxtC_Name.text = name
end

function CommonInstructionView:updateNum(desc)
	self._TxtC_Count.text = desc
end

function CommonInstructionView:_SetDesc1(desc)
	self._TxtC_Desc_1.text = desc

	self._TxtC_Desc_1:CalculateLayoutInputVertical()

	self._layoutElement.preferredHeight = math.min(200, self._TxtC_Desc_1.preferredHeight)

	self._layoutElement:CalculateLayoutInputVertical()

	self._layoutScrollRect.verticalNormalizedPosition = 1

	settimer(0.2, self.nextFrame, self, false)
end

function CommonInstructionView:nextFrame()
	self._layoutScrollRect.verticalNormalizedPosition = 1
end

function CommonInstructionView:_SetDesc2(desc)
	local isNotEmpty = not string.nilorempty(desc)

	self._TxtC_Desc_2.gameObject:SetActive(isNotEmpty)

	self._TxtC_Desc_2.text = desc
end

function CommonInstructionView:_OnClickSelf()
	CommonTipsMgr.instance:closeAllTips()
end

return CommonInstructionView
