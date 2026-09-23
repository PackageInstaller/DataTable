--角色插画类,用于显示插画和插画表情、气泡
local size={0,0}
local rect=nil;
local pivot=nil;
local blendType=nil;--立绘效果
local shaderUtil=nil;
local roleImage=nil;
local gradient = nil
local isUseShopImg=false;
local lastPath=nil;
function Awake()
	rect=ComUtil.GetCom(img,"RectTransform");
	roleImage=ComUtil.GetCom(img,"Image");
	gradient=ComUtil.GetCom(img,"UIImageGradient");
	pivot=rect.pivot;
	shaderUtil = ComUtil.GetCom(img, "UILayerBlend");
	blendType=CharacterImgShader.BlendFace;
	canvasGroup=ComUtil.GetCom(gameObject,"CanvasGroup");
	--拉扯材质
	cGrabPassInvert = ComUtil.GetCom(img, "CGrabPassInvert")
end

--useShopImg:是否使用特殊宣传图
function Init(modelID, cb,useShopImg)
	InitNull();
	cfg = Cfgs.character:GetByID(modelID);
	isUseShopImg=useShopImg;
	if cfg then
		local imgName=useShopImg and cfg.shopImg or cfg.img;
		ResUtil.ImgCharacter:Load(img, imgName, function()
			size = CSAPI.GetRTSize(img)
			local max =size[0]>size[1] and size[0] or size[1]
			CSAPI.SetRTSize(mask, max*2, max*2);
			if(cb) then
				cb(img)
			end
		end);
	end
end

function InitNull()
	CSAPI.SetGOActive(emojiNode, true);
	CSAPI.LoadImg(mask,"UIs/Common/black.png",false,nil,true);
	CSAPI.SetAngle(mask,0,0,0);
	CSAPI.SetAnchor(mask,0,0,0);
	blendType=CharacterImgShader.BlendFace;
	if shaderUtil then
		shaderUtil:Clear();
	end
	SetImgScale(1,1,1);
	if rect then
		rect.pivot=pivot;
	end
	if mask2 then
		CSAPI.RemoveGO(mask2);
	end
	SetBlack(false);
	SetRoleBlack(false);
	SetRoleRotate(0,0,0);
	roleImage.sprite=nil;
	CSAPI.SetRTSize(img,0,0);
	SetImgGradient();
	lastPath=nil;
	-- SetRoleScale();
	-- HideFace();
end

function OnRecycle()
	InitNull();
	isUseShopImg=false;
	blendType=CharacterImgShader.BlendFace;
	if canvasGroup then
		canvasGroup.alpha=1;
	end
	SetMask(true)
end

--显示面部表情，item:表情图片的配置表信息 blendType:shader类型参考GEnum中的CharacterImgShader _c1:全息效果的底色 _c2:全息效果的干扰线颜色
function SetBlend(item,_blendType,_c1,_c2)
	_blendType=_blendType or CharacterImgShader.BlendFace;
	local path=nil;
	local pos=nil;
	if item then
		--设置表情和位置
		 path = GetFacePath(item);
		 pos=UnityEngine.Vector2(item.pos[1], item.pos[2]);
	end

	if shaderUtil then
		if lastPath~=nil and lastPath~=path then
			shaderUtil:Clear();
		end
		if _c1 or _c2 then
			shaderUtil:SetBlend2(_blendType,path,pos,_c1,_c2);
		else
			shaderUtil:SetBlend(_blendType,path,pos);
		end
	end
	lastPath=path;
end

function GetFacePath(item)
	if item and cfg then
		if isUseShopImg then
			return "Bigs/Character/" .. cfg.shopImg .. "/face/" .. item.img .. ".png";
		else
			return "Bigs/Character/" .. cfg.img .. "/face/" .. item.img .. ".png";
		end
	end
	return nil;
end

function HideFace()
	-- if shaderUtil then
	-- 	shaderUtil:Clear();
	-- end
	SetBlend(nil,blendType);
end

--根据index来显示面部表情
function SetFaceByIndex(faceIndex)
	if cfg and cfg.faceID and faceIndex then
		local faceCfg = Cfgs.characterFace:GetByID(cfg.faceID);

		if faceCfg and faceCfg.item[faceIndex] then
			local item = faceCfg.item[faceIndex];
			--设置表情和位置
			SetBlend(item,blendType);
			CSAPI.SetGOActive(img,false)
			CSAPI.SetGOActive(img,true)
		-- else
		-- 	Log("<color=#c66ffc>模型表中未找到关联的表情配置："..tostring(cfg.faceID).."\t表情ID:"..cfg.faceID.."</color>");
		end
	end
end

--根据常用名称来显示面部表情
function SetFaceByName(faceName)
	if cfg and cfg.faceID then
		local faceCfg = Cfgs.characterFace:GetByID(cfg.faceID);
		if faceCfg then
			for k, v in ipairs(faceCfg.item) do
				local strs = StringUtil:split(v.img, "_");
				if strs[2] == faceName then
					SetBlend(item,blendType);
					break;
				end
			end
		end
	end
end

function SetEmoji(resName, pos, sort)
	RemoveEmoji();
	ResUtil:CreateEffect("emoji/" .. resName, pos[1], pos[2], 0, emojiNode, function(go)
		emojiGO = go;
		local render = ComUtil.GetComsInChildren(go, "Renderer");
		if render then
			for i = 0, render.Length - 1 do
				render[i].sortingOrder = render[i].sortingOrder + sort;
			end
		end
		if pos[3] ~= nil then
			local rotate = pos[3] == - 1 and 180 or 0;
			go.transform.localRotation = UnityEngine.Quaternion.Euler(0, rotate, 0);
		end
	end);
end

function RemoveEmoji()
	if emojiGO then
		CSAPI.RemoveGO(emojiGO);
		emojiGO = nil;
	end
end

--显示emoji，align：朝向1左边2右边
function SetEmojiByName(emojiName, align, sort)
	--根据EmojiName读取该表情的资源名称
	align = align == nil and 1 or align;
	if cfg then
		local emojiCfg = Cfgs.characterEmoji:GetByID(cfg.emojiID);
		if emojiCfg and emojiCfg.item then
			for k, v in ipairs(emojiCfg.item) do
				local emojiConf = Cfgs.EmojiConf:GetByID(v.emojiID);
				if emojiConf and emojiConf.name == emojiName then
					local pos = align == 1 and v.leftPos or v.rightPos;
					SetEmoji(emojiConf.resName, pos, sort);
				end
			end
		end
	end
end

function SetEmojiByIndex(emojiIndex, align, sort)
	--根据EmojiIndex读取该表情的资源名称
	align = align == nil and 1 or align;
	if cfg then
		local emojiCfg = Cfgs.characterEmoji:GetByID(cfg.emojiID);
		if emojiCfg and emojiCfg.item then
			local itemInfo = emojiCfg.item[emojiIndex];
			if itemInfo then
				local emojiConf = Cfgs.EmojiConf:GetByID(itemInfo.emojiID);
				if emojiConf then
					local pos = align == 1 and itemInfo.leftPos or itemInfo.rightPos;
					SetEmoji(emojiConf.resName, pos, sort);
				end
			end
		end
	end
end

--设置为黑色
function SetBlack(isBlack)
	-- local color = isBlack == true and {0, 0, 0, 255} or {255, 255, 255, 255};
	-- CSAPI.SetImgColor(img, color[1], color[2], color[3], color[4]);
	if img then
        UIUtil:SetLiveBroadcast(img,isBlack)
    end
end

function SetRoleBlack(isBlack,isTween)
	local value = SettingMgr:GetValue(s_other_live_key)
	if(value==1) then 
		UIUtil:SetLiveBroadcast(img,isBlack)
	else
		local color = isBlack == 1 and {0, 0, 0, 255} or {255, 255, 255, 255};
		if isTween then
			CSAPI.csSetUIColorByTime(img, "action_UIColor_to_front", color[1], color[2], color[3], color[4], nil, 0.5);
		else
			CSAPI.SetImgColor(img, color[1], color[2], color[3], color[4], true);
		end 
	end 
end

function SetRoleColorByTime(r,g,b,a,func,time)
	local value = SettingMgr:GetValue(s_other_live_key)
	if(value==1) then 
		UIUtil:SetLiveBroadcast(img,isBlack)
	else 
		CSAPI.csSetUIColorByTime(img, "action_UIColor_to_front", r,g,b,a,func,time);
	end 
end

function SetRoleScaleByTime(actionName, x, y, z, callBack, time)
	CSAPI.SetUIScaleTo(img, actionName, x or 1, y or 1, z or 1, callBack, time)
end

function SetRoleRotate(x,y,z)
	img.transform.localRotation = UnityEngine.Quaternion.Euler(x or 0,y or 0,z or 0);
end

function GetRoleScale()
	return CSAPI.GetScale(img)
end

function SetRoleScale(x,y,z)
	CSAPI.SetScale(img,x or 1,y or 1,z or 1);
end

--设置特效shader
function SetEffect(type)
	if type==nil then
		blendType=CharacterImgShader.BlendFace;
	elseif type==1 then
		blendType=CharacterImgShader.HoloEffect;
	end
	SetBlend(nil,blendType);
end

--设置位置
function SetPos(_x, _y)
	x = _x or 0;
	y = _y or 0;
	CSAPI.SetLocalPos(childNode, x, y);
end

function SetImgScale(x, y, z)
	CSAPI.SetScale(childNode, x, y, z);
end

--执行切开当前的立绘操作并返回控件(用在剧情中的切开立绘动画),angle:切开的角度,pos:数组，切割中心点
function DoSplitImg(pos,angle)
	CSAPI.LoadImg(mask,"UIs/Common/splitmask.png",false,nil,true);
	if pos==nil then
		pos={0,0}
	end
	--计算旋转中心点
	local x=(rect.pivot.x*rect.rect.width+pos[1])/rect.rect.width;
	local y=(rect.pivot.y*rect.rect.height+pos[2])/rect.rect.height;
	local pivot2=UnityEngine.Vector2(x,y);
	rect.pivot=pivot2;
	--设置img和mask的偏移位置
	CSAPI.SetAnchor(mask,pos[1],pos[2]);
	CSAPI.SetAnchor(img,0,0);
	--创建分割的另一半
	mask2=CSAPI.CloneGO(mask,childNode.transform);
	local img2=ComUtil.GetComInChildren(mask2,"UILayerBlend");
	img2.name="img2";
	mask2.name="mask2";
	if angle==nil or angle==180 then
		angle=0;
	end
	CSAPI.SetAnchor(mask2,pos[1],pos[2]);
	-- CSAPI.SetAnchor(img2,0,0);
	--设置切割数据
	CSAPI.SetAngle(mask,0,180,angle);
	CSAPI.SetAngle(mask2,0,0,angle*-1);
	CSAPI.SetAngle(img,0,180,angle);
	CSAPI.SetAngle(img2.gameObject,0,0,angle);
	return mask,mask2;
end


--拉扯
function PlayLC()
	if(cGrabPassInvert) then 
	    cGrabPassInvert:Play()
	end 
end 

function Remove()
	CSAPI.RemoveGO(gameObject);
end


function SetMask(b)
	CSAPI.SetScriptEnable(mask, "SoftMask", b)
end

function SetImgGradient(_infos)
	local keys = {}
	if _infos then
		keys = _infos.pos
	else
		table.insert(keys,{0, 100, 100, 100})
		table.insert(keys,{100, 100, 100, 100})
	end
	gradient:SetGradientColor(keys)
	gradient.enabled = _infos ~= nil
end

function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
childNode=nil;
mask=nil;
img=nil;
emojiNode=nil;
view=nil;
end
----#End#----