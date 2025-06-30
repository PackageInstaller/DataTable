--[[
-- added by wsh @ 2017-12-03
-- UI工具类
--]]
---@class UI.Util.UIUtil
local UIUtil = {}


CardPictureType =
{
	Little = 1,  --头像
	Middle = 2,  --中图（角色列表）
	Big = 3, --大图（角色一览）
	Home = 4, -- 主界面（主界面立绘）
	Original = 5, --原画
	Battle = 6,  --战斗
	SkinDefault = 7,--皮肤剪影
}

FightSoulPictureType = 
{
	Little = 1,  --头像
	Middle = 2,  --中图（列表）
	Big = 3, --大图
}

local function GetChild(trans, index)
	return trans:GetChild(index)
end

-- 注意：根节点不能是隐藏状态，否则路径将找不到
local function FindComponent(trans, ctype, path)
	assert(trans ~= nil)
	assert(ctype ~= nil)
	
	local targetTrans = trans
	if path ~= nil and type(path) == "string" and #path > 0 then
		targetTrans = trans:Find(path)
	end
	if targetTrans == nil then
		return nil
	end
	local cmp = targetTrans:GetComponent(ctype)
	if IsNull(cmp) then
		return cmp
	end
	return targetTrans:GetComponentInChildren(ctype)
end

local function FindTrans(trans, path)
	return trans:Find(path)
end

local function FindText(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Text), path)
end

local function FindImage(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Image), path)
end

local function FindButton(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Button), path)
end

local function FindInput(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.InputField), path)
end

local function FindSlider(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.Slider), path)
end

local function FindScrollRect(trans, path)
	return FindComponent(trans, typeof(CS.UnityEngine.UI.ScrollRect), path)
end

local function UIExessive(rectTransform,deplay,dir,isOpen,callBack) --1上2下3左4右
	local curPos = rectTransform.position;
	local screenWidth = CS.UnityEngine.Screen.width;
	local screenHeight = CS.UnityEngine.Screen.height;
	local switch = {
		[1] = Vector2.New( curPos.x,curPos.y + screenHeight),
		[2] = Vector2.New( curPos.x,curPos.y - screenHeight),
		[3] = Vector2.New(curPos.x - screenWidth ,curPos.y),
		[4] = Vector2.New(curPos.x + screenWidth,curPos.y),
	}
	if(isOpen) then
		if(curPos.x == 0 and curPos.y == 0) then
			DoTweenManager.DOAnchorPos3D(rectTransform,-switch[dir],0,callBack);
		end
		DoTweenManager.DOAnchorPos3D(rectTransform,Vector2.zero,deplay,callBack);
	else
		DoTweenManager.DOAnchorPos3D(rectTransform,switch[dir],deplay,callBack);
	end
end

local function GetButtonDataComponent(gameObject)
	local bindData = gameObject:GetComponent("BindData")
	if bindData == nil then
		BindData.Get(gameObject);
		bindData = gameObject:GetComponent("BindData");
	end
	bindData:RemoveAll();
	return bindData;
end


-- 获取直属画布
local function GetCanvas(ui_component)
	-- 初始化直属画布
	local canvas = nil
	if ui_component._class_type == UILayer then
		canvas = ui_component
	else
		local now_holder = ui_component.holder
		while now_holder ~= nil do	
			local var = ui_component:GetComponents(UICanvas)
			if table.count(var) > 0 then
				assert(table.count(var) == 1)
				canvas = var[1]
				break
			end
			now_holder = now_holder.holder
		end
	end
	assert(canvas ~= nil)
	return canvas
end

UIUtil.SpriteTab = {};
UIUtil.AtlasConfigTab = {};

function UIUtil.ClearSpriteTab()
	UIUtil.SpriteTab = {};
	UIUtil.AtlasConfigTab = {};
end

local function SetSprite(image, atlasConfig,sprite_name,isCoroutine)
	if IsNull(image) then
		error("--设置图片的对象不存在!")
		return
	end

	isCoroutine = isCoroutine or true
	if atlasConfig == nil or sprite_name == nil then image.sprite = nil; return end
	local path
	if atlasConfig == AtlasConfig.SkillIcon then
		path = SpriteHead.."SkillIcon/"..sprite_name..".png"
	elseif atlasConfig == AtlasConfig.Equip then
		path = SpriteHead.."EquipIcon/"..sprite_name..".png"
	elseif  atlasConfig == AtlasConfig.Item then
		path = SpriteHead.."ItemIcon/"..sprite_name..".png"
	elseif atlasConfig == AtlasConfig.SummonRare then
		path = SpriteHead.."SummonRareFrame/"..sprite_name
	else
		path = atlasConfig.AtlasPath .. "/"..sprite_name
	end

	local func = function()
		image:DOFade(0, 0)
		image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path)
		image:DOFade(1, 0)
	end

	if isCoroutine then
		coroutine.start(func);
	else
		func();
	end
end

function UIUtil.SetSpriteByPath(image, path,isCoroutine)
	if IsNull(image) then
		error("--设置图片的对象不存在!")
		return
	end

	isCoroutine = isCoroutine or true
	if path == nil then image.sprite = nil; return end

	local func = function()
		image:DOFade(0, 0)
		image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path)
		image:DOFade(1, 0)
	end

	if isCoroutine then
		coroutine.start(func);
	else
		func();
	end
end

SpriteHead = "UI/"
AtlasHead = "UI/Atlas/"

IsClean = false

function UIUtil.SetCardSprite(image,templateId,skinId, cardPictureType,isCoroutine) --设置角色图片
	local path
	local suffix = "" --(IsClean == true and {""} or {"_"} )[1]
	if skinId == nil then skinId = 1 end 
	skinId = (skinId == 0 and {1} or {skinId})[1]
	templateId = (templateId == 0 and {1001} or {templateId})[1]
	local zClean = Z_Clean[templateId]
	local subPath = "/" ..templateId.."_"..skinId

	if cardPictureType == CardPictureType.Little then
		if zClean ~= nil and zClean.CardLittle[skinId] == 1 then
			subPath = subPath..suffix
		end
		path = AtlasHead.."CardLittle"..subPath
	elseif cardPictureType == CardPictureType.Middle then
		if zClean ~= nil and zClean.CardMiddle[skinId] == 1 then
			subPath = subPath..suffix
		end
		path = SpriteHead.."CardMiddle"..subPath
		-- 和谐
		local skin = table.first(Z_Skin, function (v) return v.BelongCard == templateId and v.Stage == skinId end)
		if skin ~= nil then
			path = SpriteHead.."CardMiddle"..skin.CardMiddle..subPath
		end
	elseif cardPictureType == CardPictureType.Big then
		if zClean ~= nil and zClean.CardBig[skinId] == 1 then
			subPath = subPath..suffix
		end
		path = SpriteHead.."CardBig"..subPath
		-- 和谐
		local skin = table.first(Z_Skin, function (v) return v.BelongCard == templateId and v.Stage == skinId end)
		if skin ~= nil then
			path = SpriteHead.."CardBig"..skin.CardBig..subPath
		end
	elseif cardPictureType == CardPictureType.Home then
		if zClean ~= nil and zClean.CardPaint[skinId] == 1 then
			subPath = subPath..suffix
		end
		path = SpriteHead.."CardPaint"..subPath
		-- 和谐
		local skin = table.first(Z_Skin, function (v) return v.BelongCard == templateId and v.Stage == skinId end)
		if skin ~= nil then
			path = SpriteHead.."CardPaint"..skin.CardPaint..subPath
		end
	elseif cardPictureType == CardPictureType.Original then
		path = SpriteHead.."CardOriginal"..subPath
	elseif cardPictureType == CardPictureType.Battle then
		if zClean ~= nil and zClean.CardBattle[skinId] == 1 then
			subPath = subPath..suffix
		end
		path = AtlasHead.."CardBattle"..subPath
	elseif cardPictureType == CardPictureType.SkinDefault then
		path = SpriteHead .. "CardSkinDefault/skin_default_" .. templateId
	end
	path = path .. ".png"

	local func = function()
		--image:DOFade(0,1)
		--image.enabled = false
		image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
		--image.enabled = true
		--image:DOFade(1,1)
	end

	if isCoroutine then
		coroutine.start(func);
	else
		func();
	end
end

function UIUtil.NewSetCardSprite(image, templateId, skinId, cardPictureType,isCoroutine)
	local path

	if skinId == nil then
		skinId = templateId * 100 + 1
	end
	
	templateId = (templateId == 0 and {1001} or {templateId})[1]
	local subPath = "/"  --.. Z_Skin[skinId].StageImage
	-- if Z_Skin[skinId] == nil then
	-- 	subPath = subPath .. templateId .. "_1"
	-- else
	-- 	subPath = subPath .. Z_Skin[skinId].StageImage
	-- end
	subPath = subPath .. Z_FigureAsset[skinId].ListHalfBody

	if cardPictureType == CardPictureType.Little then
		path = AtlasHead.."CardLittle"..subPath
	elseif cardPictureType == CardPictureType.Middle then
		path = SpriteHead.."CardMiddle"..subPath
	elseif cardPictureType == CardPictureType.Big then
		path = SpriteHead.."CardBig"..subPath
	elseif cardPictureType == CardPictureType.Home then
		path = SpriteHead.."CardPaint"..subPath
	elseif cardPictureType == CardPictureType.Original then
		path = SpriteHead.."CardOriginal"..subPath
	elseif cardPictureType == CardPictureType.Battle then
		path = AtlasHead.."CardBattle"..subPath
	elseif cardPictureType == CardPictureType.SkinDefault then
		path = SpriteHead .. "CardSkinDefault/skin_default_" .. templateId
	end
	path = path .. ".png"

	local func = function()
		image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path)
	end

	if isCoroutine then
		coroutine.start(func);
	else
		func();
	end
end


function UIUtil.SetFightSoulSprite(image,fightSoulId,fightSoulPictureType,isCoroutine)
	local path
	local suffix = ""--(IsClean == true and {""} or {"_"} )[1]
	local templateId = fightSoulId

	local zClean = Z_Clean[templateId]
	local subPath = "/"..templateId

	if fightSoulPictureType == FightSoulPictureType.Little then
		if zClean ~= nil and zClean.FightSoulLittle == 1 then
			subPath = subPath..suffix
		end
		path = AtlasHead.."FightSoul"..subPath
	elseif fightSoulPictureType == FightSoulPictureType.Middle then
		if  zClean ~= nil and zClean.FightSoulMiddle == 1 then
			subPath = subPath..suffix
		end
		path = SpriteHead.."FightSoulMid"..subPath
		-- 和谐
		local skin = table.first(Z_Skin, function (v) return v.BelongCard == templateId end)
		if skin ~= nil then
			path = SpriteHead.."FightSoulMid"..skin.FightSoulMid..subPath
		end
	elseif fightSoulPictureType == FightSoulPictureType.Big then
		if  zClean ~= nil and zClean.FightSoulBig == 1 then
			subPath = subPath..suffix
		end
		path = SpriteHead.."FightSoulLarge"..subPath
		-- 和谐
		local skin = table.first(Z_Skin, function (v) return v.BelongCard == templateId end)
		if skin ~= nil then
			path = SpriteHead.."FightSoulLarge"..skin.FightSoulLarge..subPath
		end
	end
	path = path .. ".png"

	local func = function()
		image:DOFade(0,1)
		-- if image.sprite == nil then
		-- 	Logger.LogError("UIUtil.SetFightSoulSprite, image.sprite is nil. cardId: " .. cardId .. " fightSoulPictureType: " .. fightSoulPictureType)
		-- else
		image.sprite = AtlasManager:GetInstance():CoLoadImageAsync(path);
		-- end
		image:DOFade(1,1)
	end

	if isCoroutine then
		coroutine.start(func);
	else
		func();
	end
end



-- 注意：必须先赋值text，且text在层级试图显示才可调用  参数1：滚动的text  参数二：滚动的宽度或者父物体或者nil 参数三：速度 参数四：初始居中，初始左对齐
function UIUtil.ScrollText(text, parent, speed)
	coroutine.start(function()
		--local mySequence = nil
		text.transform:DOKill()
		local fitter = text.gameObject:GetComponent("ContentSizeFitter")
		if fitter == nil then
			fitter = text.gameObject:AddComponent(typeof(CS.UnityEngine.UI.ContentSizeFitter))
		else
			fitter.enabled = false
			coroutine.waitforframes(1)
			fitter.enabled = true
		end
		fitter.horizontalFit = 2
		local rectTransform = text:GetComponent("RectTransform")
		rectTransform.anchorMin = Vector2.New(0.5, 0.5)
		rectTransform.anchorMax = Vector2.New(0.5, 0.5)
		-- 锚点为0左对齐， 锚点为0.5，中间对齐， 锚点为1，右边对齐
		local pivotX = rectTransform.pivot.x
		coroutine.waitforframes(1)
		--if not text.gameObject.activeInHierarchy then
		--	print("--滚动字disable")
		--end
		local width = rectTransform.sizeDelta.x
		local parentWidth = 0
		if parent == nil then
			parentWidth = text.transform.parent:GetComponent("RectTransform").sizeDelta.x
		else
			if type(parent) == "number" then
				parentWidth = parent
			else
				parentWidth = parent:GetComponent("RectTransform").sizeDelta.x
			end
		end
		speed = speed or 25
		local initX = parentWidth * pivotX - parentWidth / 2 
		text.transform:DOLocalMoveX(initX, 0)
		--local startX = initX + (1 - pivotX) * parentWidth + width * pivotX - parentWidth +25 -- (width + parentWidth) / 2
		--local endX = initX - (1 - pivotX) * width - parentWidth * pivotX -- -(width + parentWidth) / 2
		--local t = text.transform:DOLocalMoveX(endX, (width + parentWidth) / speed)
		--t:SetEase(Ease.Linear)

		--TODO 开启循环后无法停止 只能用DOTween.Kill全部杀死。。。
		--local mySequence = DOTween.Sequence()
		--mySequence:Append(text.transform:DOLocalMoveX(startX, 0))
		--mySequence:Append(t )
		--mySequence:AppendInterval(3)
		--mySequence:Append(text.transform:DOLocalMoveX(startX, 0))
		--mySequence:Append(t)
		--mySequence:SetAutoKill(true);
		--mySequence:Pause();
		
		
		if parentWidth >= width then
			--mySequence:SetAutoKill(false);
			--mySequence:Pause();
			
			--DOTween.Kill("Sequence", false);
			--mySequence.timeScale = 0;
			
		else
			local str = text.transform:GetComponent("Text").text
			if  str == nil  then
				return
			end
			
			text.transform:GetComponent("Text").text = str .."  " .. str
			--mySequence:PlayForward()
			--mySequence:SetLoops(-1)
			
			local startX = initX + (1 - pivotX) * parentWidth + width*2 * pivotX - parentWidth +25 -- (width + parentWidth) / 2
			local endX = (0 - (1 - pivotX*2) * width - parentWidth/2 )-- -(width + parentWidth) / 2
			text.transform:DOLocalMoveX(startX, 0)
			local t = text.transform:DOLocalMoveX(endX, (width + parentWidth) / speed)
			t:SetEase(Ease.Linear)
			t:SetLoops(-1)
		end
		
	end)
end

-- 设置图片以父节点mask完整显示
function UIUtil.SetImageMaxByParent(img, pixelsPerUnit)
	pixelsPerUnit = pixelsPerUnit or 100
	img:SetNativeSize()
	local width = img.sprite.bounds.size.x * pixelsPerUnit
	local height = img.sprite.bounds.size.y * pixelsPerUnit
	local parentTnf = img.transform.parent:GetComponent("RectTransform")
	local tnf = img.transform:GetComponent("RectTransform")
	local delta = parentTnf.sizeDelta.x / parentTnf.sizeDelta.y
	local x, y
	if width / height > delta then -- 宽度足够大，以高度为准
		y = parentTnf.sizeDelta.y
		x = width * parentTnf.sizeDelta.y / height
	else
		x = parentTnf.sizeDelta.x
		y = height * parentTnf.sizeDelta.x / width
	end
	tnf.sizeDelta = Vector2.New(x, y)
end

function UIUtil.SetPlayerIcon(image,iconStr)
	if iconStr == "" then
		UIUtil.SetSprite(image,AtlasConfig.CardLittle,"1000_1.png",true)
	 else
		UIUtil.SetSprite(image,AtlasConfig.CardLittle,iconStr .. ".png",true)
	 end
end

function UIUtil.SetCardPaint(self,image,card)
	local zCard
	if card == nil then
		zCard = Z_Card[1025]
	else
		zCard = Z_Card[card.TemplateId];
	end
	
	--if self.paintAnim ~= nil then
	--	ListChildPool:GetInstance():RemoveCardPaintAnim(self.paintAnim);
	--self.paintAnim = nil
	--end

	--if zCard.CardAnim ~= "" then
	--image.gameObject:SetActive(false);
	--ListChildPool:GetInstance():CreateCardPaintAnim(zCard.CardAnim,self.camera,function(object)
	--self.paintAnim = object;
	--if zCard.Id == 1003 then
	--self.paintAnim.transform.localPosition = Vector3.New(-395,-901,932)
	--self.paintAnim.transform.localScale = Vector3.New(135,135,135)
	--else
	--self.paintAnim.transform.localPosition = Vector3.New(-90,-128.5,1000)
	--self.paintAnim.transform.localScale = Vector3.New(800,800,800)
	--end
	--end)
	--else
		UIPublic.SetPainting(zCard,image)
		image.gameObject:SetActive(true);
	--end


end




local function GetRCComponent(gameObject)
	return gameObject:GetComponent(typeof(CS.ReferenceCollector));
end

local function ToolTipFirst(tooltip_first_data)
	--.title =
	--.message
	--.callBack
	--.cancelCallBack
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipFirst,tooltip_first_data);
end

function UIUtil.ToolTipFirstStarLight(tooltip_first_data)
	--.title =
	--.message
	--.callBack
	--.cancelCallBack
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipFirstStarLight,tooltip_first_data);
end

function UIUtil.ToolTipFirstChooseCount(data)
	--self.message = data.message
	--self.title = data.title
	--self.tempId = data.tempId
	--self.maxCount = data.maxCount
	--self.callBack = data.callBack
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipFirstChooseCount,data);
end

local function ToolTipFirstPlus(tooltip_first_data)
	--.title =
	--.message
	--.callBack
	--.cancelCallBack
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipFirstPlus,tooltip_first_data);
end

function UIUtil.ToolTipSecond(title,msg,callBack)
	local data = {};
	data.title = title;
	data.message = msg;
	data.callBack = callBack;
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipSecond,data);
end

function UIUtil.ToolTipThird(title,msg,sandNum,goldNum)
	local data = {};
	data.title = title;
	data.message = msg;
	data.callBack = callBack
    data.goldNum = goldNum
    data.sandNum = sandNum
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipThird,data);
end

function UIUtil.ToolTipFourth(msg, time, callback, data)
	if not string.IsNullOrEmpty(msg) then
		ToolTipFourthClass.New(msg, time, callback, data);
	end
end

function UIUtil.ToolTipSix(msg,mode)
	return ToolTipSixClass.New(msg,mode);
end

function UIUtil.ToolTipSeven(title, msg, callBack)
	local data = {};
	data.title = title;
	data.message = msg;
	data.callBack = callBack;
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipSeven, data);
end

function UIUtil.ToolTipEight(general_data)
	UIManager:GetInstance():OpenWindow(UIWindowNames.ToolTipEight, general_data);
end

function UIUtil.OpenSkipHint(callBack,state) --stage : 1下面  2上面
	local info = {}
	info.state = state or 1
	info.callBack = callBack
	UIManager:GetInstance():OpenWindow(UIWindowNames.UISkipHint,info)
end


function UIUtil.ScientificCount(num, count) -- count 显示多少位数
	if num == nil then num = 0 end
	if count == nil then count = 10000 end
	
	if num > 1000000 or #tostring(num) > count then
		local tempNum = num / 1000;
		local a,b = math.modf(tempNum)
		--local c = math.floor(b*10)/10 
		--if c == 0.0 then c = 0 end
		return a .."K";
	end
	return math.modf(num);
end

local function SetPlayerCurrency(type,num)
	local player = Game.Scene.Player;
	if type == 1 then
		player.PaidStarStone = num;
	elseif type == 2 then
		player.FreeStarStone = num;
	elseif type == 3 then
		player.StarSand = num;
	elseif type == 4 then
		player.MagicCrystal = num;
	elseif type == 5 then
		player.EmperorStarPoint = num;
	elseif type >= 5001 and type <= 5999 then -- 星尘
		local item = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(v) return v.TemplateId == type end)
		if item then item.Amount = num end
	end
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
end

local function GetPlayerCurrency(type)
	local player = Game.Scene.Player;
	if type == 1 then
		return player.PaidStarStone;
	elseif type == 2 then
		return player.FreeStarStone;
	elseif type == 3 then
		return player.StarSand;
	elseif type == 4 then
		return player.MagicCrystal;
	elseif type == 5 then
		return player.EmperorStarPoint;
	elseif type >= 5001 and type <= 5999 then -- 星尘
		local item = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(v) return v.TemplateId == type end)
		return item and item.Amount or 0
	end
end

function UIUtil.RemoveItem(itemId,num)
	local player = Game.Scene.Player;
	local Items = player:GetComponent("ItemComponent").Items;
	local item =Items[itemId];
	item.Amount = item.Amount - num;
	if item.Amount == 0 then
		player:GetComponent("ItemComponent"):Remove(itemId);
	end
end

function UIUtil.OpenBattleSettleWindow(req, rsp) --打开结算面板
	if req.battle_result == BattleResultType.BattleResultWin or rsp.level_type == LevelType.LevelTypeArena then
		req.rsp = rsp
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattleSettle, req,rsp)
	else
		--local tooltip_first_data = {};
		--tooltip_first_data.title = "通关失败";
		--tooltip_first_data.message = "点击确认返回主界面";
		--tooltip_first_data.callBack = function() Game.Scene.SceneComponent:SwitchScene(SceneConfig.HomeScene) end
		--tooltip_first_data.cancelCallBack = function() Game.Scene.SceneComponent:SwitchScene(SceneConfig.HomeScene) end
		--UIUtil.ToolTipFirst(tooltip_first_data);
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIBattleLose)
	end
	--Game.Scene:GetComponent("SupCardComponent"):ResetAids()
	--UIData.ResetCurTeam()
end

---@param showData {showType:number, tempId:number}
function UIUtil.OpenThingsDetailWindow(showData, isBag)
	if showData.showType == ShowType.Equip then--装备
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIEquipProp,{TemplateId = showData.tempId })
	elseif showData.showType == ShowType.Item then
		local zItem = Z_Item[showData.tempId]
		local isOptionalSkin = false
		if zItem.UseType == ItemUseType.ItemUseTypeOptionalRewardPack then
			local zOptionalRewardPack = Z_OptionalRewardPack[zItem.UseParams[1]]
			for i, v in ipairs(zOptionalRewardPack) do
				if v.RewardType == RewardType.RewardTypeCharacter 
						or v.RewardType == RewardType.RewardTypeCharacterSkin
						or v.RewardType == RewardType.RewardTypeFightSoul then
					isOptionalSkin = true
					break
				end
			end
		end
		if isOptionalSkin then
			UIManager:GetInstance():OpenWindow(UIWindowNames.UIOptionalSkin, {
				tempId = showData.tempId,
				isUse = false,
			})
		elseif zItem.LevelJump ~= nil and table.count(zItem.LevelJump) > 0 and isBag then
			UIManager:GetInstance():OpenWindow(UIWindowNames.UIThingsDetailBagItem,showData)
		else
			UIManager:GetInstance():OpenWindow(UIWindowNames.UIThingsDetailItem,showData)
		end
	elseif showData.showType == ShowType.Card then
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIThingsDetailCard,showData)
	elseif showData.showType == ShowType.CardSkin then
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIShowSkin, showData.tempId)
	elseif showData.showType == ShowType.FightSoul then
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIThingsDetailFightSoul,showData)
	else
		UIManager:GetInstance():OpenWindow(UIWindowNames.UIThingsDetail,showData)
	end
end

function UIUtil.SetRewardInfo(v, avatar, data, isShowThingsDetail)
	if not data then data = {} end
	local config = {}
	local Kind
	data.goodId = v.TemplateId
	if v.RewardTypeInfo == "Unknown" then -- Unknown

	elseif v.RewardTypeInfo == "Item" then --Item
		config = Z_Item[v.TemplateId]
		config.Num = v.Num
		Kind = GoodsKind.Item
	elseif v.RewardTypeInfo == "Card" then --Card
		config = Z_Card[v.TemplateId]
		config.Num = 1
		Kind = GoodsKind.Card
	elseif v.RewardTypeInfo == "Equip" then
		config = Z_Equip[v.TemplateId]
		config.Num = 1
		Kind = GoodsKind.Equip
	elseif v.RewardTypeInfo == "FightSoul" then --FightSoul
		config = Z_FightSoul[v.TemplateId]
		config.Num = 1
		Kind = GoodsKind.FightSoul
	elseif v.RewardTypeInfo == "StarStone" then --StarStone
		config = Z_Currency[3]
		config.Num = v.Num
		Kind = GoodsKind.FreeStarStone
	elseif v.RewardTypeInfo == "GoldCoin" then --GoldCoin
		config = Z_Currency[1]
		config.Num = v.Num
		Kind = GoodsKind.GoldCoin
	elseif v.RewardTypeInfo == "MagicCrystal" then --MagicCrystal
		config = Z_Currency[5]
		config.Num = v.Num
		Kind = GoodsKind.MagicCrystal
	elseif v.RewardTypeInfo == "StarSand" then --星沙
		config = Z_Currency[4]
		config.Num = v.Num
		Kind = GoodsKind.StarSand
	elseif v.RewardTypeInfo == "EmperorStarPoint" then--星皇点
		config = Z_Currency[6]
		config.Num = v.Num
		Kind = GoodsKind.EmperorStarPoint
	elseif v.RewardTypeInfo == "DemonPoint" then--幽魂碎片
		config = Z_Currency[7]
		config.Num = v.Num
		Kind = GoodsKind.DemonPoint
	elseif v.RewardTypeInfo == "StarLight" then --星光石
		config = Z_Currency[2]
		config.Num = v.Num
		Kind = GoodsKind.PaidStarStone
	elseif v.RewardTypeInfo == "Skin" then--皮肤
		config = Z_Skin[v.TemplateId]
		data.goodId = config.BelongCard
		data.skinId = config.Stage
		config.Num = 1
		Kind = GoodsKind.CardSkin
	end
	UIPublic.InitItemIcon(avatar, data.IconBg, Kind, data.goodId, {iconId = data.skinId})
	if data.numText then
		data.numText.text = config.Num
	end
	if isShowThingsDetail then
		UIUtil.AddBtnEvent(avatar.gameObject,function() 
			UIPublic.OpenThingsDetail(Kind, v.TemplateId) 
		end)
	end
	return config
end

function UIUtil.CheakRewardInfo(dataList)
	for _, v in pairs(dataList) do
		if v.RewardTypeInfo == "Item" and not Z_Item[v.TemplateId] then
			return false
		elseif v.RewardTypeInfo == "Card" and not Z_Card[v.TemplateId] then
			return false
		elseif v.RewardTypeInfo == "FightSoul" and not Z_FightSoul[v.TemplateId] then
			return false
		elseif v.RewardTypeInfo == "Equip" and not Z_Equip[v.TemplateId] then
			return false
		elseif v.RewardTypeInfo == "Skin" and not Z_Skin[v.TemplateId] then
			return false
		end
	end
	return true
end

function UIUtil.getStringLength(inputstr)
	if not inputstr or type(inputstr) ~= "string" or #inputstr <= 0 then
		return nil
	end
	local length = 0  -- 字符的个数
	local i = 1
	while true do
		local curByte = string.byte(inputstr, i)
		local byteCount = 1
		if curByte > 239 then
			byteCount = 4  -- 4字节字符
		elseif curByte > 223 then
			byteCount = 3  -- 汉字
		elseif curByte > 128 then
			byteCount = 2  -- 双字节字符
		else
			byteCount = 1  -- 单字节字符
		end
		-- local char = string.sub(inputstr, i, i + byteCount - 1)
		-- print(char)  -- 打印单个字符
		i = i + byteCount
		length = length + 1
		if i > #inputstr then
			break
		end
	end
	return length
end



local function charsize(ch)
if not ch then return 0
elseif ch >=252 then return 6
elseif ch >= 248 and ch < 252 then return 5
elseif ch >= 240 and ch < 248 then return 4
elseif ch >= 224 and ch < 240 then return 3
elseif ch >= 192 and ch < 224 then return 2
elseif ch < 192 then return 1
end
end

function UIUtil.utf8sub(str, startChar, numChars)
	local startIndex = 1
	while startChar > 1 do
		local char = string.byte(str, startIndex)
		startIndex = startIndex + charsize(char)
		startChar = startChar - 1
	end

	local currentIndex = startIndex

	while numChars > 0 and currentIndex <= #str do
		local char = string.byte(str, currentIndex)
		currentIndex = currentIndex + charsize(char)
		numChars = numChars -1
	end
	return str:sub(startIndex, currentIndex - 1)
end

function UIUtil.AddBtnSound(gameObject,soundType)
	if IsNull(gameObject) then return end
	Game.Scene:GetComponent("SoundComponent"):AddBtnEvent(gameObject,soundType)
end

function UIUtil.OnPlayerLevelChange(level,exp)
	if level == 0 then return end 
	local player = Game.Scene.Player;
	if level ~= player.Level then
		--local str = LangUtil.GetSysLang(1059)..":"..level.."\n"..Z_PlayerLevelUp[level].Remark;--玩家等级提升
		--UIUtil.ToolTipThird(LangUtil.GetSysLang(1060),str);--"升级"
	
		-- 升级埋点
		ChannelManager:GetInstance():LevelUpCallback(level)
		
		if string.IsNullOrEmpty(Z_PlayerLevelUp[level].Remark) then
			UIUtil.ToolTipFourth(LangUtil.GetSysLang(1059)..":"..level)
		else
			UIUtil.ToolTipFourth({LangUtil.GetSysLang(1059)..":"..level, Z_PlayerLevelUp[level].Remark})
		end
	end
	player.Level = level;
	player.Exp = exp;
	-- TapDB.setLevel(level);
	
	DataManager:GetInstance():Broadcast(DataMessageNames.ON_PLAYER_INFO_CHG);
end

local function GetExpAdd(level,exp) --计算获得的经验
	local player = Game.Scene.Player;
	if level == player.Level then
		return exp - player.Exp
	else
		local x = level - player.Level
		local expCount = 0
		for i = 1,x do
			if Z_PlayerLevelUp[player.Level + i] ~= nil then
				expCount = 	expCount + Z_PlayerLevelUp[player.Level + i ].Exp
			end
		end
		expCount = expCount + exp - player.Exp
		return expCount
	end
end
--dengji 5 jingyan765
function UIUtil.BattleSettle(g2cData,data)
	Logger.Log("===========BattleSettle======================")
	local player = Game.Scene.Player;
	data.IsLevelUp = g2cData.PlayerLevel > player.Level
	local addExp = GetExpAdd(g2cData.PlayerLevel, g2cData.PlayerExp)
	data.AddExp = addExp
	data.RewardInfoList = g2cData.RewardInfoList;
	player.Energy = g2cData.PlayerEnergy;
	UIUtil.OnPlayerLevelChange(g2cData.PlayerLevel, g2cData.PlayerExp);
	UIUtil.OpenBattleSettleWindow(data);
	UIUtil.ClearSupportCard();
end

function UIUtil.ClearAllTeamSupport()
	print("--清除所有支援角色");
	local TeamList = Game.Scene.Player:GetComponent("TeamComponent"):GetTeams()
	for a,b in pairs(TeamList) do
		local team = b;
		for k,v in pairs(team.TeamDetailList) do
			if v.IsSupport == true then
				table.removebyvalue(team.TeamDetailList, v);
				break;
			end
		end
	end
end

function UIUtil.ClearSupportCard()
	UIUtil.ClearAllTeamSupport();
end

function UIUtil.GetAppVersion()
	local AssetBundleManager = CS.AssetBundles.AssetBundleManager.Instance;
	local creater = AssetBundleManager:RequestAssetFileAsync("app_version.bytes")
	creater:Start();
	return  creater.text;
end


function UIUtil.IfIOSPlatform(func)
	if CS.UnityEngine.Application.platform == 8 then
		return func()
	end
end

function UIUtil.IfAndroidPlatform(func)
	if CS.UnityEngine.Application.platform == 11 then
		return func();
	end
end

function UIUtil.IfPCPlatform(func)
	if CS.UnityEngine.Application.platform == 2 then
		return func();
	end
end


function UIUtil.ActiveFitter(gameObject)
	local contentSizeFitter = gameObject:GetComponent("VerticalLayoutGroup");
	if contentSizeFitter ~= nil then
		coroutine.start(function ()
			contentSizeFitter.enabled = false;
			coroutine.waitforframes(2);
			contentSizeFitter.enabled = true;
		end)
	end
end

function UIUtil.RemoveNilData(objectList,dataList)
	for k,v in pairs(objectList) do
		if dataList[k] == nil then
			ListChildPool:GetInstance():Remove(v);
			objectList[k] = nil;
		end
	end
end

function UIUtil.ShowDetail(title,message,iconName,type)
	local data = {};
	data.title = title
	data.message = message
	data.iconName = iconName
	data.type = type
	UIManager:GetInstance():OpenWindow(UIWindowNames.UIDetail,data);
end

function UIUtil.GetTimeStampDifference(timeStamp) --通过时间戳 计算与当前时间得差值得 h,m,s
	local hour,min,second,s
	local s1 = timeStamp
	local s2 = TimeUtil.OSTime()
	s = os.difftime(s2, s1)
	s = string.format("%.2d:%.2d:%.2d", math.modf(s/(60*60)), math.modf(s/60%60), math.modf(s%60))
	local timeInfo = string.split(s,":");
	hour = tonumber(timeInfo[1]);
	min = tonumber(timeInfo[2]);
	second = tonumber(timeInfo[3]);
	return hour,min,second;
end

function UIUtil.GetCountDown(timeStamp)
	local hour,min,second,s
	local s1 = TimeUtil.OSTime()
	local s2 = timeStamp
	s = os.difftime(s2, s1)
	s = string.format("%.2d:%.2d:%.2d", math.modf(s/(60*60)), math.modf(s/60%60), math.modf(s%60))
	local timeInfo = string.split(s,":");
	hour = tonumber(timeInfo[1]);
	min = tonumber(timeInfo[2]);
	second = tonumber(timeInfo[3]);
	return hour,min,second;
end



local function GetRevers(t)
	for k,v in pairs(t) do
		v = -v;
	end
end

function UIUtil.GetTimeDifference(time1,time2) --时分秒差值运算
	local time = {}
	local time1_greater = true
	time.h = time1.h - time2.h;
	time.m = time1.m - time2.m;
	time.s = time1.s - time2.s;

	if time.h < 0 then  time1_greater = false; GetRevers(time) end
	if time.h == 0 and time.m < 0 then time1_greater = false;GetRevers(time)  end
	if time.h == 0 and time.m == 0 and time.s < 0 then time1_greater = false; time.s = -time.s end

	if time.s < 0 then
		time.s = time.s + 60;
		time.m = time.m - 1;
	end

	while(true) do
		if time.m >= 0 then break end;
		time.m = time.m + 60;
		time.h = time.h - 1;
	end
	
	return time,time1_greater;
end

local countDown = 0 
local isCountDown = false

local function DoCountDown()
	if isCountDown == false then
		coroutine.start(function()
			while(true) do
				coroutine.waitforseconds(0.1)
				if countDown >= 0.1 then
					countDown = countDown - 0.1
				end
			end
		end)
	end
end


function UIUtil.AddBtnEvent(gameObject,callBack,soundType)
	if IsNull(gameObject) then
		Logger.LogError("UIUtil.AddBtnEvent  gameObject is null")
		return
	end
	if callBack == nil then return end
	
	DoCountDown()
	isCountDown = true
	gameObject = gameObject.gameObject
	local button = gameObject:GetComponent("Button")
	if IsNull(button) then
		button = gameObject:AddComponent(typeof(CS.UnityEngine.UI.Button))
	end
	button.enabled = true
	button.onClick:RemoveAllListeners()
	local buttonEventListener = gameObject:GetComponent(typeof(CS.ButtonEventListener))
	coroutine.start(function()  
		if not IsNull(buttonEventListener) then
			CS.UnityEngine.GameObject.Destroy(buttonEventListener)
			coroutine.waitforframes(2)
		end
	
		UIUtil.AddBtnSound(gameObject,soundType)
		ButtonListener.Get(gameObject).OnClickHandler = 
		function() 
			if callBack ~= nil then
				callBack() 
			end
		end 
	end)
end

function UIUtil.AddBtnEventNoBug(gameObject, callBack, soundType)
	if IsNull(gameObject) then
		Logger.LogError("gameObject is null")
		return
	end
	if callBack == nil then return end
	gameObject = gameObject.gameObject
	local button = gameObject:GetComponent("Button")
	if IsNull(button) then
		button = gameObject:AddComponent(typeof(CS.UnityEngine.UI.Button))
	end
	button.enabled = true
	button.onClick:RemoveAllListeners()
	local buttonEventListener = gameObject:GetComponent(typeof(CS.ButtonEventListener))
	if not IsNull(buttonEventListener) then
		CS.UnityEngine.GameObject.DestroyImmediate(buttonEventListener)
	end
	UIUtil.AddBtnSound(gameObject, soundType)
	ButtonListener.Get(gameObject).OnClickHandler = function() if callBack then callBack() end end
end

function UIUtil.GetSevenStarConfig(day,diff)
	if diff > SevenStarMaxDiff then diff = SevenStarMaxDiff end
	local zSevenStarId = tonumber(day..diff)
	local zConfig = require("Config/Excel/Z_SevenStarLevel"..Z_SevenStar[zSevenStarId].ConfigName)
	return zConfig[diff]
end

function UIUtil.GetDayForWeek()
	if Game.Scene and Game.Scene.Player then
		local serverDay = Game.Scene.Player:GetComponent("SevenStarComponent").ServerDay
		if serverDay then
			return serverDay
		end
	end
	-- TimeUtil.ServerDate
	local day = os.date("%w",  TimeUtil.getNewDate(TimeUtil.OSTime(),-4, 'HOUR'))--4点更新
	day = tonumber(day)
	if day == 0 then day = 7 end
	return day
end

function UIUtil.GetRefreshTime(type, data)--获得的时间差可能为0 负，需要处理
	-- if type == 2 then--周一
	-- 	local day = UIUtil.GetDayForWeek()
	-- 	return TimeUtil.getNewDate(math.floor(TimeUtil.OSTime() / 86400) * 86400,20 + (7 - day) * 24, 'HOUR')
	-- elseif type == 4 then--争霸
	-- 	local com = Game.Scene:GetComponent("CompetitionComponent")
	-- 	if not com.info or not com.info.EndDate or os.difftime(com.info.EndDate, TimeUtil.OSTime()) <= 0 then
	-- 		coroutine.start(function()
	-- 			com:GetCompetitionInfo(function()
	-- 				local window = UIManager:GetInstance():GetWindow(UIWindowNames.UITask)
	-- 				local isWindowActive = window ~= nil and window.Active
	-- 				if isWindowActive then
	-- 					window.View.refreshTime = com.info.EndDate
	-- 				end
	-- 			end)
	-- 		end)
	-- 		return 0
	-- 	else
	-- 		return com.info.EndDate
	-- 	end
	-- elseif type == 5 then--开服
	-- 	return TimeUtil.getNewDate(Game.Scene:GetComponent("SessionComponent").DateTime , 28 , 'DAY')
	-- elseif type == 6 then--魑魅活动
	-- elseif type == 10 then--注册时间
	-- 	if data and data.day then
	-- 		return TimeUtil.getNewDate(Game.Scene.Player.RegisterTime, data.day, 'DAY')
	-- 	end
	-- 	return Game.Scene.Player.RegisterTime
	-- end
	
	-- --1.每天
	-- return TimeUtil.getNewDate(math.floor(TimeUtil.OSTime() / 86400) * 86400,20, 'HOUR')
	return 1
end

function UIUtil.GetTimeForm(type)
	return UIUtil.ConvertTimeForm(UIUtil.GetDiffTime(type))
end

function UIUtil.GetDiffTime(type)
	return os.difftime(UIUtil.GetRefreshTime(type), TimeUtil.OSTime())
end

function UIUtil.ConvertTimeForm(second)
	if second < 0 then second = 0 end
	local tb = {}
	tb.day     = math.floor(second/86400)--math.modf(s/(24*60*60))
	tb.hour    = math.fmod(math.floor(second/3600), 24)--math.modf(s/(60*60))
	tb.minute  = math.fmod(math.floor(second/60), 60)--math.modf(s/60%60)
	tb.second  = math.floor(math.fmod(second, 60))-- math.modf(s%60)
	return tb
end
	
local function toolTip(callback)
	local tipData = {}
	local tipData1 = {}
	local tipData2 = {}
	tipData.title = LangUtil.GetSysLang(9)--"提示"
	tipData.type = 2
	tipData.startType = 0
	tipData.message = LangUtil.GetSysLang(1075)--"确定使用100星石开放一小时"
	tipData.But2 = function()
		if Game.Scene.Player.FreeStarStone < 100 then
			tipData1.title = LangUtil.GetSysLang(9)--"提示"
			tipData1.type = 2
			tipData1.startType = 1
			tipData1.message = LangUtil.GetSysLang(545)--"星石不足，是否使用星光石补充?"
			tipData1.But2=function()
				if Game.Scene.Player.FreeStarStone +  Game.Scene.Player.PaidStarStone < 100 then
					tipData2.title = LangUtil.GetSysLang(9)--"提示"
					tipData2.type = 2
					tipData2.startType = 2
					tipData2.message = LangUtil.GetSysLang(546)--"星石不足，是否前往购买?"
					tipData2.But2=function()
						UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstPlus);
						UIManager:GetInstance():CloseWindow(UIWindowNames.UISevenStarSectionInfo);
						UIManager:GetInstance():OpenWindow(UIWindowNames.UIStarLightStoneShop)
					end
					UIUtil.ToolTipFirstPlus(tipData2)
				else
					if callback~=nil then callback()end
					UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstPlus);
				end
			end
			UIUtil.ToolTipFirstPlus(tipData1)
		else
			if callback~=nil then callback()end
			UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipFirstPlus);
		end

	end
	
	UIUtil.ToolTipFirstPlus(tipData)
end


function UIUtil.OpenBattleModel(diff, day)
	local item = table.first(Game.Scene.Player:GetComponent("ItemComponent").Items,function(v) return v.TemplateId == 3014 end)
	local func = function(isItem)
		local price = 100
		PublicRequest.SendOpenBattleModeRequest(price, isItem, diff, day)
	end

	if item ~= nil then
		local tipData = {}
		tipData.title = LangUtil.GetSysLang(9)
		tipData.type = 5
		tipData.startType =1
		tipData.message = LangUtil.GetSysLang(1097)--"是否优先消耗'时之沙漏'开放此模式1小时?"
		tipData.Amount = item.Amount
		tipData.TemplateId = 3014
		--tipData.ExpenseNum = 1 --需要消耗一张
		--tipData.Amount = item.Amount
		tipData.But2 = function()
			func(true)
		end
		UIUtil.ToolTipFirstPlus(tipData)
	else
		local tipData = {}
		tipData.title = LangUtil.GetSysLang(9)
		tipData.type = 5
		tipData.startType = 2
		tipData.message = LangUtil.GetSysLang(1095)--"是否优先消耗'时之沙漏'开放此模式1小时?"
		tipData.Amount = 0
		tipData.TemplateId = 3014
		--tipData.ExpenseNum = 1 --需要消耗一张
		--tipData.Amount = item.Amount
		tipData.But2 = function()
			UIManager:GetInstance():OpenWindow(UIWindowNames.UIGeneralShop)
			UIManager:GetInstance():CloseWindow(UIWindowNames.UISevenStarSectionInfo)
		end

		UIUtil.ToolTipFirstPlus(tipData)
	end
end

function UIUtil.GetMonsterNum(monsterList)
	if not monsterList then
		local recordComponent = Game.Scene.Player:GetComponent("RecordComponent")
		monsterList = recordComponent.MonsterTypeList
	end
	local holdCount = 0
	for i, v in ipairs(monsterList) do
		if Z_Card[v].IsMonster == 1 and Z_Card[v].NotOpen ~= 1 then
			holdCount = holdCount + 1
		end
	end
	return holdCount
end

function UIUtil.GetStorySectionNum(storyTypeList)
	local storyComponent = Game.Scene.Player:GetComponent("StoryComponent")
	local openChapter = table.choose(Z_StoryChapter,function (k,v) return v.IsOpen == 1 and v.IsLock ~= 1 end)
	local storyIds = {}
	
	for _, v in pairs(openChapter) do--开的章节，通关
		if storyTypeList ~= nil and type(storyTypeList) == "table" then
			storyIds[v.ChapterId] = 0
			table.walk(storyTypeList, function(_, s)
				if Z_StorySection[s] and Z_StorySection[s].ChapterId == v.ChapterId and storyIds[v.ChapterId] < s then
					storyIds[v.ChapterId] = s
				end 
			end)
		else
			storyIds[v.ChapterId] = storyComponent:GetCompletedSection(v.ChapterId)[1]
		end
	end
	
	local max = 0
	local completed = 0
	for _, v in pairs(Z_StorySection) do--剧情总数
		if storyIds[v.ChapterId] ~= nil and not string.IsNullOrEmpty(v.StoryId) then
			max = max + 1
			if v.Id <= storyIds[v.ChapterId] then
				completed = completed + 1
			end
		end
	end
	
	if max == 0 then
		return 0
	end
	
	return math.modf((completed / max) * 100)
end

function UIUtil.BattaleActiveWindow(self)
	local windows = UIManager:GetInstance().windows
	local isLayer = table.any(windows,function(v)
		return v.Active and (v.Layer:GetName() == UILayers.InfoLayer.Name or
				v.Layer:GetName() == UILayers.BackgroudLayer.Name or v.Layer:GetName() == UILayers.NormalLayer.Name) end)
	return isLayer
end

function UIUtil.OpenCardList(data)
	UIManager:GetInstance():OpenWindow(UIWindowNames.UICardList,data)
end

function UIUtil.OpenFormat(data)
	UIManager:GetInstance():OpenWindow(UIWindowNames.UIFormatNew,data)
end

local function GetEquipDepartmentName()
	local tb = {}
	for i = 686,717 do
		table.insert(tb,LangUtil.GetSysLang(i))
	end
	return tb
end

UIUtil.currencyType = {[1] = LangUtil.GetSysLang(2),[2] = LangUtil.GetSysLang(3),[3] = LangUtil.GetSysLang(4),[4] = LangUtil.GetSysLang(5),[5] = LangUtil.GetSysLang(6)}
UIUtil.quotaType = {[1] = "天",[2] = "周",[3] = "月"}; -- ignoreCN

UIUtil.EquipDepartmentName = GetEquipDepartmentName()
UIUtil.EquipTab = {[1] = "HP",[2] = "ATK",[3] = "DEF",[4] = "SPD"}

function UIUtil.GetEquipTpis(z_equip)
	if z_equip.Exclusive ~= 0 then
		return z_equip.BaseAttr
	end
	local id=z_equip.BaseAttrType[1]
	if #z_equip.BaseAttrVal >2 then
		return UIUtil.EquipTab[id].."+"..z_equip.BaseAttrVal[1].."~"..z_equip.BaseAttrVal[2];
	else
		return UIUtil.EquipTab[id].."+"..z_equip.BaseAttrVal[1]
	end
end

-- 获取字符串长度，包括中英文
function UIUtil.LimitString(str, len)
	local lenInByte = #str
	local arr = {}
	local index = 0
	for i = 1, lenInByte do
		local curByte = string.byte(str, i)
		local byteCount = 1
		if curByte > 0 and curByte <= 127 then
			byteCount = 1
			index = index + 1
			arr[index] = string.sub(str, i, i + byteCount - 1)
		elseif curByte >= 192 and curByte <= 223 then
			byteCount = 2
			index = index + 1
			arr[index] = string.sub(str, i, i + byteCount - 1)
		elseif curByte >= 224 and curByte <= 239 then -- utf-8 汉字 3个字节
			byteCount = 3
			index = index + 1
			arr[index] = string.sub(str, i, i + byteCount - 1)
		elseif curByte >= 240 and curByte <= 247 then
			byteCount = 4
			index = index + 1
			arr[index] = string.sub(str, i, i + byteCount - 1)
		end
	end
	local destStr = ""
	local over = table.count(arr) > len
	local length = table.count(arr) > len and len or table.count(arr)
	for i = 1, length do
		destStr = destStr..arr[i]
	end
	return destStr, over
end


function UIUtil.activityBUt(tf,mode,sorting,type)
	local Image = tf.transform:GetComponent("Image")
	local bg = tf.transform.parent:Find("bg")
	local activityReward = table.choose(Z_ActivityReward,function (a,b) return b.LevelType == type end)
	local reward = nil

	for _,v in pairs(activityReward) do

	end
	
	if reward ~=nil and  TimeUtil.OSTime() >= reward.Start and  reward.End > TimeUtil.OSTime() then
		local tb = TimeUtil.ConvertTimeForm( os.difftime( reward.End, TimeUtil.OSTime()))
		if mode == 1 then -- 活动标签
			LangUtil.GetSpriteLang(360, function(sprite)
				Image.sprite = sprite
			end)
			if not IsNull(bg) then
				if tb.day>0  then
					LangUtil.BindText(bg.transform:Find("Text")).text = string.gsub(LangUtil.GetSysLang(964),"x",tb.day)
				else
					LangUtil.BindText(bg.transform:Find("Text")).text = string.gsub(LangUtil.GetSysLang(965),"x",tb.hour)
				end
				bg.gameObject:SetActive(true)
			end
		else -- 2倍活动标签
			LangUtil.GetSpriteLang(361, function(sprite)
				Image.sprite = sprite
			end)
		end
		tf.gameObject:SetActive(true)
	else
		tf.gameObject:SetActive(false)
		if not IsNull(bg) then
			bg.gameObject:SetActive(false)
		end
	end
	table.csenu(tf.transform:Find("HuoDong1/Particle"):GetComponentsInChildren(typeof(CS.UnityEngine.ParticleSystemRenderer),true),function (smr)
		smr.sortingOrder = sorting
	end)
	UIUtil.AcyivityDORotate(tf)
	
	
end

function UIUtil.AcyivityDORotate(tf)
	if IsNull(tf) then
		return
	end
	coroutine.start(function()
		if not IsNull(tf) then
			tf.transform:DOLocalRotate(Vector3.New(0, 0, -10), 0.25);
		end
		coroutine.waitforseconds(0.25)
		if not IsNull(tf) then
			tf.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0.25);
		end
		coroutine.waitforseconds(0.25)
		if not IsNull(tf) then
			tf.transform:DOLocalRotate(Vector3.New(0, 0, -10), 0.25);
		end
		coroutine.waitforseconds(0.25)
		if not IsNull(tf) then
			tf.transform:DOLocalRotate(Vector3.New(0, 0, 0), 0.25);
		end
		coroutine.waitforseconds(2.25)
		if not IsNull(tf) then
			UIUtil.AcyivityDORotate(tf)
		end
	end )
end

function UIUtil.ActivityTwoReward(type)
	local activityReward = table.choose(Z_ActivityReward,function (a,b) return b.LevelType == type end)
	local reward = nil
	for _,v in pairs(activityReward) do

	end
	
	return reward~=nil and  TimeUtil.OSTime() >= reward.Start and  reward.End > TimeUtil.OSTime()
end

function UIUtil.AcyivitySettleReward()
	local againstComponent = Game.Scene:GetComponent("AgainstComponent")
	if againstComponent.LevelType == LevelType.LevelTypeSevenStar and UIUtil.ActivityTwoReward(1)  then
		return true
	elseif againstComponent.LevelType == LevelType.LevelTypeChallenge and againstComponent.BattleData.Challenge.sctionId < 200 and  UIUtil.ActivityTwoReward(2) then
		return true
	elseif  againstComponent.LevelType == LevelType.LevelTypeChallenge and againstComponent.BattleData.Challenge.sctionId < 300 and againstComponent.BattleData.Challenge.sctionId > 200  and  UIUtil.ActivityTwoReward(3) then
		return true
	end
	return false
end

function UIUtil.EquipFightSoul(teamType, teamId, fightSoulId, isEquip)
	local id = teamType .. teamId
	---@type FightSoul
	local fightSoul = Game.Scene.Player:GetComponent("FightSoulComponent"):Get(fightSoulId)
	fightSoul:ChangeEquip(isEquip)
end

UIUtil.GetPlayerCurrency = GetPlayerCurrency
UIUtil.SetPlayerCurrency = SetPlayerCurrency

UIUtil.GetRCComponent = GetRCComponent
UIUtil.SetSprite = SetSprite
UIUtil.GetChild = GetChild
UIUtil.FindComponent = FindComponent
UIUtil.FindTrans = FindTrans
UIUtil.FindText = FindText
UIUtil.FindImage = FindImage
UIUtil.FindButton = FindButton
UIUtil.FindInput = FindInput
UIUtil.FindSlider = FindSlider
UIUtil.FindScrollRect = FindScrollRect
UIUtil.UIExessive = UIExessive
UIUtil.GetButtonDataComponent = GetButtonDataComponent
UIUtil.ToolTipFirst = ToolTipFirst
UIUtil.ToolTipFirstPlus = ToolTipFirstPlus

return ConstClass("UIUtil", UIUtil)