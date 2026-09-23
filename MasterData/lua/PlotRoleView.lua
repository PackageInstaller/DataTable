--剧情对话的人物插图信息
local roleImgInfo = nil;

local tween_focus_scale; --获取焦点的动画
local isTalker = false;
local isBlack = false;--是否变黑

local scale = nil
local cImg = nil;

function SetImg(data)
	if cImg == nil then
		cImg = ResUtil:CreateCharacterImg(mask.transform);
		scale = cImg.GetRoleScale();
	end
	--初始化立绘
	if data == nil then
		LogError("设置人物立绘时出现错误！数据不能为空！");
		return;
	end
	this.data = data;
	--获取立绘信息
	roleImgInfo = RoleImgInfo.New();
	roleImgInfo:InitCfg(data.id);
	cImg.Init(roleImgInfo:GetModelID());
	SetBlack(data.black);
	if data.effect then
		SetEffect(data.effect);
	end
	local rScale = roleImgInfo:GetScale();
	cImg.SetImgScale(rScale, rScale, rScale);
	--设置子物体遮罩偏移
	local posList = roleImgInfo:GetMaskOffset();
	CSAPI.SetAnchor(cImg.gameObject, posList[1], posList[2]);
	--设置遮罩大小
	local size=roleImgInfo:GetMaskSize();
	CSAPI.SetRTSize(mask,size[1],size[2]);
	SetImgRotate();
	--设置层级
	SetLayer();
	--设置渐变
	if data.gradient then
		cImg.SetImgGradient(roleImgInfo:GetGradientInfo())
	end
	--设置透明度
	if data.alpha and tonumber(data.alpha) >= 0 then
		CSAPI.SetGOAlpha(mask,tonumber(data.alpha))
	end
	if data.turn then --翻转
		local x = (data.turn == 1 or data.turn == 3) and -1 or 1
		local y = (data.turn == 2 or data.turn == 3) and -1 or 1
		CSAPI.SetScale(mask,x,y,1)
	else
		CSAPI.SetScale(mask,1,1,1)
	end
end

--判断当前是否是同一张图片
function IsEqual(imgId)
	return this.data.id == imgId;
end

--设置变黑
function SetBlack(black, isTween)
	isBlack= black and black==1;
	cImg.SetRoleBlack(black, isTween);
end

--设置立绘状态
function SetImgState(isTalk)
	-- local opacity=isTalk and 1 or 0.7; --透明度变化
	local colorPercent = isTalk and 1 or 0.4;--颜色变化
	colorPercent = isBlack and 0 or colorPercent;
	cImg.SetRoleColorByTime(math.floor(colorPercent * 255), math.floor(colorPercent * 255), math.floor(colorPercent * 255), 255, nil, 0.09);
	-- CSAPI.SetImgColor(cImg.img.gameObject,math.floor(colorPercent*255),math.floor(colorPercent*255),math.floor(colorPercent*255),255,false);
	if isTalker == false and isTalk then
		isTalker = true;
		transform:SetSiblingIndex(2); --设置为最上层
		SetImgRotate();
		cImg.SetRoleScaleByTime(nil, scale, scale, 1, nil, 0.09)
	elseif isTalker == true and isTalk == false then
		isTalker = false;
		_scale = scale * 0.9
		cImg.SetRoleScaleByTime(nil, scale, scale, 1, nil, 0.09)
		-- SetLayer();
		-- if tween_focus_scale==nil then
		--     tween_focus_scale=CSAPI.ApplyAction(cImg.gameObject,"Img_Focus_Scale");
		-- else
		--     tween_focus_scale:Play();
		-- end
	end	
end

function OnRecycle()
	isTalker = false;
	isBlack = false;--是否变黑
	if cImg then
		-- cImg.Remove();
		cImg = nil;
	end
end

function SetImgRotate()
	local posList = roleImgInfo:GetRoleImgPos();
	local dir = 1;
	if posList then
		dir = posList[this.data.pos] [3] == nil and 1 or posList[this.data.pos] [3];
	end
	local rotate = dir == - 1 and 180 or 0;
	if cImg then
		cImg.SetRoleRotate(0, rotate, 0)
	end
end

--设置面部表情
function SetFace(index)
	if index and index ~= - 1 then --初始化面部表情
		cImg.SetFaceByIndex(index);
	else
		--隐藏面部表情
		cImg.HideFace();
	end
end

--设置立绘效果
function SetEffect(type)
	cImg.SetEffect(type);
end

--设置气泡表情
function SetEmoji(index, align)
	if index and index ~= - 1 then --初始化emoji
		align = align == nil and 1 or align;
		cImg.SetEmojiByIndex(index, align, 30);
	else
		--删除emoji
		cImg.RemoveEmoji();
	end
end

--设置层级
function SetLayer()
	if this.data.pos == PlotAlign.Left then
		transform:SetSiblingIndex(1);
	elseif this.data.pos == PlotAlign.Center then
		transform:SetSiblingIndex(0);
	elseif this.data.pos == PlotAlign.Right then
		transform:SetSiblingIndex(2);
	end
end

--获取立绘位置
function GetPos()
	return this.data.pos
end

--判断是否是说话人
function IsTalk(talkId)
	return this.data.id == talkId;
end

function SetMask(isShow)
	CSAPI.SetScriptEnable(mask, "SoftMask", isShow);
	cImg.SetMask(not isShow) --双softMask需要关闭最下层上层才能生效
end

--返回当前朝向的立绘位置
function GetTargetPos()
	local posList = roleImgInfo:GetRoleImgPos();
	local posList2 = roleImgInfo:GetMaskOffset();
	local pos = {0, 0};
	if posList and posList[this.data.pos] then
		--由于子物体使用了中间的坐标，这里返回的父物体位置需要减去子物体的坐标偏移
		-- pos = {posList[this.data.pos] [1] - posList2[1]*-1, posList[this.data.pos] [2]};
		pos=posList[this.data.pos];
	end
	return pos;
end

--入场动画
function PlayImgEntrance(time,callBack, delay, pos2)
	local pos = GetTargetPos();
	CSAPI.SetLocalPos(gameObject, pos[1], pos[2], 0);
	-- view.myLocalPosX = pos[1];
	-- view.myLocalPosY = pos[2];
	if this.data.enter == PlotImgTweenType.Fade then
		PlotTween.FadeIn(cImg.gameObject, 0.15, callBack, delay);
	elseif this.data.enter == PlotImgTweenType.Move then
		PlotTween.EntranceTweenMove(view, pos, time,function()
			if callBack ~= nil then
				callBack();
			end
		end, delay);
	elseif this.data.enter == PlotImgTweenType.MoveAndFade then
		time = time or 0.17
		pos2 = pos2 or {0,0}
		CSAPI.SetLocalPos(gameObject, pos[1] + pos2[1], pos[2]+ pos2[2], 0);
		PlotTween.TweenMove(gameObject, pos, time)
		PlotTween.FadeIn(cImg.gameObject, time, callBack, delay);
	end
end

--移动动画
function PlayImgMove(pos, time, callBack, delay)
	PlotTween.TweenMove(view, pos, time, callBack, delay);
end

--复位动画
function PlayImgMoveByPingPong(pos, time, callBack, delay)
	PlotTween.TweenMoveByPingPong(view,pos, time, callBack, delay)
end

--渐变移动动画
function PlayImgMoveByFade(time, callBack, delay, pos2)
	local pos = GetTargetPos();
	time = time or 0.17
	if this.data.moveTo == PlotImgTweenType.Fade then
		local _callback = function()
			CSAPI.SetLocalPos(gameObject, pos[1], pos[2], 0);
			if callBack then
				callBack()
			end
		end
		PlotTween.Twinkle(cImg.gameObject, time, _callback, delay)
	elseif this.data.moveTo == PlotImgTweenType.MoveAndFade then --入场加入移动
		pos2 = pos2 or {0,0}
		local _callback = function()
			CSAPI.SetLocalPos(gameObject, pos[1] + pos2[1], pos[2]+ pos2[2], 0);
			PlotTween.TweenMove(gameObject,pos,time)
			if callBack then
				callBack()
			end
		end
		PlotTween.Twinkle(cImg.gameObject, time, _callback, delay)
	else
		CSAPI.SetLocalPos(gameObject, pos[1], pos[2], 0);
	end
end


--退场动画
function PlayImgLeave(time, callBack, delay, isBgChange,pos2)
	onLeave = callBack;
	if isBgChange then --当背景进行切换时取消人物退场动画改为直接退场
		OnLeave()
		return
	end
	if this.data.out == PlotImgTweenType.Fade then
		PlotTween.FadeOut(cImg.gameObject, nil, OnLeave, delay);
	elseif this.data.out == PlotImgTweenType.Move then
		local pos = GetTargetPos();
		-- view.myLocalPosX=pos[1];
		-- view.myLocalPosY=pos[2];
		PlotTween.LeaveTweenMove(view, pos, time, OnLeave, delay);
	elseif this.data.out == PlotImgTweenType.SplitImg then --切割退场
		SetMask(false);
		local go1, go2 = cImg.DoSplitImg(this.data.splitTweenPoint, this.data.splitAngel);
		PlotTween.TweenSplit(go1, go2, OnLeave, delay);
	elseif this.data.out == PlotImgTweenType.MoveAndFade then
		time = time or 0.17
		local pos = GetTargetPos();
		pos2 = pos2 or {0,0}
		CSAPI.SetLocalPos(gameObject, pos[1], pos[2], 0);
		PlotTween.TweenMove(gameObject, {pos[1] + pos2[1],pos[2]+ pos2[2]}, time)
		PlotTween.FadeOut(cImg.gameObject, time, callBack, delay);
	else
		OnLeave();
	end
end

function OnLeave()
	if onLeave ~= nil then
		onLeave();
	end
	CSAPI.SetGOAlpha(mask,1)
	CSAPI.RemoveGO(gameObject);
	-- if view ~= nil and IsNil(view) ~= true then
	-- 	view:Close();
	-- end
end

function SetOut(type)
	this.data.out = type
end

function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	mask = nil;
	view = nil;
end
----#End#----
