-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/DrawcardresultView.lua

module("logic.extensions.lottery.view.DrawcardresultView", package.seeall)

local DrawcardresultView = class("DrawcardresultView", ViewComponent)

function DrawcardresultView:ctor()
	DrawcardresultView.super.ctor(self)

	self.can_close = false
end

function DrawcardresultView:buildUI()
	DrawcardresultView.super.buildUI(self)

	self.bg = self:getBtn("bg")
	self.givePetTxt = self:getGo("givePetTxt"):GetComponent("Text")
	self.cardCell = {}
	self.qualityBg = {}
	self._cellEffect = {}
	self.pet_img = {}
	self.img_newtag = {}
	self.levelBg = {}
	self._qualityBgMask = {}

	for i = 1, 10 do
		self.cardCell[i] = self:getGo("CardGird/cardCell_" .. i)
		self.qualityBg[i] = self:getGo("CardGird/cardCell_" .. i .. "/qualityBg"):GetComponent("UIImageSpriteChange")

		local cellEffect_go = self:getGo("CardGird/cardCell_" .. i .. "/celleffect")

		self._cellEffect[i] = PhotoEffect.Get(cellEffect_go)

		self._cellEffect[i]._go:SetActive(false)

		local _rawImage = cellEffect_go:GetComponent("RawImage")

		MaterialUtils.SetRTRawImageAlpha(_rawImage, 0)

		local _petMaskImg = self:getGo("CardGird/cardCell_" .. i .. "/conMask")

		_petMaskImg:SetActive(true)

		self.pet_img[i] = self:getGo("CardGird/cardCell_" .. i .. "/conMask/con")
		self.img_newtag[i] = self:getGo("CardGird/cardCell_" .. i .. "/img_newtag")
		self.levelBg[i] = self:getGo("CardGird/cardCell_" .. i .. "/levelBg")
		self._qualityBgMask[i] = self:getGo("CardGird/cardCell_" .. i .. "/qualityBgMask"):GetComponent("UIImageColorChange")
	end

	self.givePetTxt.text = ""
	self._shareBtn = self:getBtn("canvas/shareBtn")
	self._btnTen = self:getBtn("btnTen")
end

function DrawcardresultView:bindEvents()
	DrawcardresultView.super.bindEvents(self)
	self.bg:AddClickListener(function()
		if self.can_close then
			self.can_close = false

			self:ClearPhotoEffect()
			self:ClearSSREffect()
			self:_clearRes()
			self:close()
		end
	end, self)
	self._shareBtn:AddClickListener(function()
		ShareController.instance:share(1, {
			self._shareBtn.gameObject
		}, nil, 200291)
	end)
	self._btnTen:AddClickListener(self._onClickbtnTen, self)
end

function DrawcardresultView:unbindEvents()
	DrawcardresultView.super.unbindEvents(self)
	self.bg:RemoveClickListener()
	self._shareBtn:RemoveClickListener()
	self._btnTen:RemoveClickListener()
end

function DrawcardresultView:destroyUI()
	DrawcardresultView.super.destroyUI(self)
end

function DrawcardresultView:onEnter()
	DrawcardresultView.super.onEnter(self)

	self.givePetTxt.text = ""

	local coinInfo = LotteryModel.instance.buyGoldInfo

	if coinInfo and coinInfo.count > 0 then
		local cfg = LotteryConfig.instance:GetPoolCfg(coinInfo.poolId)

		if cfg == nil then
			return
		end

		local pointPrize = cfg.pointPrize

		if GameUtil.isEmptyString(pointPrize) then
			self.givePetTxt.text = langPara("成功购买%s金币,并额外赠送：", coinInfo.count)
		else
			local pointType, pointId, pointNum = MaterialMgr.getMatParams(pointPrize)

			self.givePetTxt.text = langPara("成功购买%s金币，赠送%s点%s，并额外赠送：", coinInfo.count, pointNum * 10, MaterialMgr.getMaterialsName(pointType, pointId))
		end

		goutil.setActive(self._btnTen.gameObject, cfg.tenDrawInResult)
	end

	local effect_path = {
		[1] = "fx_ui_chouka/fx_ui_chouka_r.prefab",
		[2] = "fx_ui_chouka/fx_ui_chouka_ssr.prefab"
	}

	self._effectRareList = {}

	local prize = ShareController.instance.activeByTimes(1, goutil.findChild(self._shareBtn.gameObject, "bubble"))

	self._shareProxy = MaterialMgr.setCellByCfg(prize, goutil.findChild(self._shareBtn.gameObject, "bubble/reward"))

	local pet_face_list = LotteryController.instance:GetPetCurFaceList()
	local pet_rare_list = LotteryController.instance:GetPetRareList()

	if not pet_face_list or not pet_rare_list then
		self:close()

		return
	end

	for i = 1, 10 do
		uGuiUtil.setSpriteToImage(self.pet_img[i].gameObject, uGuiUtil.SpriteType.BigBg, GameUrl.getLotteryPetImgUrl(pet_face_list[i].raceid))
		self.img_newtag[i]:SetActive(pet_face_list[i].new_pet)

		local rare = pet_rare_list[i]

		self._qualityBgMask[i]:SetState(rare - 1)
		self.qualityBg[i]:ChangeSprite("board_zh_0" .. 5 - rare)

		if rare > 2 then
			local effect_path = effect_path[rare - 2]
			local _effectRare = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
				return
			end, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
			end)

			_effectRare:setParent(self.qualityBg[i].transform)
			_effectRare:setScaleXYZ(1.22, 1, 1)
			table.insert(self._effectRareList, _effectRare)
		end

		self.levelBg[i].transform.localPosition = rare == 4 and Vector3.New(0, 276, 0) or Vector3.New(0, 245, 0)
	end

	settimer(1, self._canCloseTag, self, false)
	AudioPlayerEx.instance:playEffect(30210)
end

function DrawcardresultView:_clearEffectRareList()
	if self._effectRareList then
		for k, v in pairs(self._effectRareList) do
			if self._effectRareList[k] then
				UIEffectManager.instance:stopEffect(self._effectRareList[k])

				self._effectRareList[k] = nil
			end
		end

		self._effectRareList = nil
	end
end

function DrawcardresultView:HidePetImg()
	if self.pet_img then
		for i = 1, 10 do
			self.pet_img[i]:SetActive(false)
		end
	end
end

function DrawcardresultView:InitResLoad(resName, index, _call_back)
	local key_resName = resName .. index

	self._resLoader = self._resLoader or {}
	self.resloader_respath_map = self.resloader_respath_map or {}
	self._resLoader[key_resName] = MultiResLoader.New()

	local res_path = GameUrl.getPetImgUrl(resName)

	self._resLoader[key_resName]:setResPaths({
		res_path
	})

	self.resloader_respath_map[self._resLoader[key_resName]] = res_path

	self._resLoader[key_resName]:load(function()
		local res_path = self.resloader_respath_map[self._resLoader[key_resName]]
		local res = self._resLoader[key_resName]:getResource(res_path)

		if res then
			local main_asset = res:GetMainAsset()

			if main_asset and _call_back then
				_call_back(main_asset)
			end
		end
	end, nil, self)
end

function DrawcardresultView:_clearRes()
	if self.temp_material then
		for k, v in pairs(self.temp_material) do
			goutil.destroy(self.temp_material[k])

			self.temp_material[k] = nil
		end

		self.temp_material = nil
	end

	if self._resLoader then
		for k, v in pairs(self._resLoader) do
			if self._resLoader[k] then
				GameUtil.unloadMultiResLoaderResource(self._resLoader[k])

				self._resLoader[k] = nil
			end
		end

		self._resLoader = nil
	end
end

function DrawcardresultView:ClearPhotoEffect()
	if self._cellEffect then
		for i = 1, 10 do
			if self._cellEffect[i] then
				self._cellEffect[i]:clear()
			end
		end
	end
end

function DrawcardresultView:ClearSSREffect()
	if self.ssr_quality_effect then
		for k, v in pairs(self.ssr_quality_effect) do
			if self.ssr_quality_effect[k] then
				UIEffectManager.instance:stopEffect(self.ssr_quality_effect[k])

				self.ssr_quality_effect[k] = nil
			end
		end

		self.ssr_quality_effect = nil
	end
end

function DrawcardresultView:onEnterFinished()
	DrawcardresultView.super.onEnterFinished(self)
end

function DrawcardresultView:onExit()
	DrawcardresultView.super.onExit(self)
	LotteryController.instance:startStopDrawBgmMusic()

	LotteryModel.instance.buyGoldInfo = nil

	self:_clearBigbg()
	self:_clearEffectRareList()
	removetimer(self._canCloseTag, self)
	GlobalDispatcher:dispatch(GlobalNotify.LotteryEndForResolve)
	MaterialMgr.resetAll(self._shareProxy)
end

function DrawcardresultView:_canCloseTag()
	ViewBlockMgr.instance:blockClick(false, kBlockKeyViewLoading)

	self.can_close = true
end

function DrawcardresultView:_clearBigbg()
	if not self.pet_img then
		return
	end

	for i = 1, 10 do
		local bigImg = Framework.ImageBigBG.Get(self.pet_img[i])

		if bigImg then
			bigImg:ClearImage()
		end
	end
end

function DrawcardresultView:onExitFinished()
	DrawcardresultView.super.onExitFinished(self)
end

function DrawcardresultView:_onClickbtnTen()
	local coinInfo = LotteryModel.instance.buyGoldInfo

	if coinInfo and coinInfo.count > 0 then
		local poolCfg = LotteryConfig.instance:GetPoolCfg(coinInfo.poolId)
		local isEnough, matType, matId, matNum, needNum, sttt = LotteryController.instance:getLotteryNeedConsume(10, poolCfg)

		if not isEnough then
			self:close()
			FloatWordMgr.instance:show("抽卡道具不足")
		else
			local zkStr, zk, zkCfg = LotteryModel.instance:getPoolConsumePlan(poolCfg)
			local groupId = LotteryController.instance:getGroupIdByPoolId(poolCfg.poolId)

			LotteryController.instance:SetRecordNeedCount(10)
			LotteryController.instance:CSRequestLuckDraw(10, poolCfg.poolId, groupId, sttt, (not string.nilorempty(zkStr) and zkCfg and zkCfg.subId or nil) and zkCfg.subId)
			self:close()
		end
	else
		printError("未再次抽奖成功")
		self:close()
	end
end

return DrawcardresultView
