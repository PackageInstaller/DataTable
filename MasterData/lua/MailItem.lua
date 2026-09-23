local canvasGroup = nil
local textMove = nil
function Awake()
	textMove = ComUtil.GetCom(nameMask,"TextMove")
end

function SetClickCB(_cb)
	cb = _cb
end

function SetIndex(idx)
	index = idx
end

--邮件item
function Refresh(_data, _elseData)
	if(_data) then
		data = _data
		SetNew()
		SetName()
		SetTime()
		SetAlpha(_elseData.selectID)
		SetColor(_elseData.selectID)
		SetState()
	end
end
function OnRecycle()		
	goodsItem = nil
end

function Remove()	
	CSAPI.RemoveGO(gameObject);
end

function SetNew()
	if data:GetRewards() and #data:GetRewards() > 0 then
		CSAPI.SetGOActive(newImg, data:GetIsGet() == MailGetType.No)
	else
		CSAPI.SetGOActive(newImg, data:GetIsRead() == MailReadType.No)
	end
end
function SetName()
	if not IsNil(textMove) then
		textMove:SetText(data:GetName())
	end
	-- CSAPI.SetText(txtName, data:GetName())
end

function SetTime()
	--time
	CSAPI.SetText(txtTime1, data:StartTime())
	--剩余
	--CSAPI.SetText(txtTime2, "")-- data:EndTime())
	CSAPI.SetText(txtTime2, data:EndTime())
end

--设置是否选中时透明度 优先度：选择->领取物品->读邮件
function SetAlpha(_selectID)		
	if not canvasGroup then		
		canvasGroup = ComUtil.GetCom(clickNode, "CanvasGroup")
	end
	local alpha = 0.3
	if(_selectID and _selectID == data:GetID()) then
		alpha = 1
	elseif data:GetIsRead() == MailReadType.No then
		alpha = 1
	elseif data:GetRewards() and #data:GetRewards() > 0 then
		alpha = data:GetIsGet() == MailGetType.No and 1 or 0.3
	end
	canvasGroup.alpha = alpha
end

--设置是否选中时颜色
function SetColor(_selectID)
	if _selectID then
		local isSel = _selectID == data:GetID()
		--bg
		CSAPI.SetGOActive(nolImg, not isSel)
		CSAPI.SetGOActive(selImg, isSel)
		
		local color1 = isSel and {0, 0, 0, 255} or {255, 255, 255, 204}
		--txt
		CSAPI.SetTextColor(txtTime1, color1[1], color1[2], color1[3], color1[4])
		CSAPI.SetTextColor(txtName, color1[1], color1[2], color1[3], color1[4])
		
		--icon
		local color = isSel and {0, 0, 0, 255} or {255, 255, 255, 255}
		CSAPI.SetImgColor(open1, color[1], color[2], color[3], color[4])
		CSAPI.SetImgColor(open2, color[1], color[2], color[3], color[4])
		CSAPI.SetImgColor(close1, color[1], color[2], color[3], color[4])
		CSAPI.SetImgColor(close2, color[1], color[2], color[3], color[4])
	end
end

--设置图标状态
function SetState()
	local index = 0
	local isReward = false	
	if(data:GetRewards() and #data:GetRewards() > 0) then
		isReward = true
	end
	
	if isReward then
		index = data:GetIsGet() == MailGetType.Yes and 3 or 4
	else
		index = data:GetIsRead() == MailReadType.Yes and 1 or 2
	end
	
	SetImgShow(index)
end

--图标显示
--1.无物品已打开 2.无物品未打开 3.有物品已打开 4。有物品未打开
function SetImgShow(index)
	CSAPI.SetGOActive(open1, index == 1)
	CSAPI.SetGOActive(close1, index == 2)
	CSAPI.SetGOActive(open2, index == 3)
	CSAPI.SetGOActive(close2, index == 4)
end


function OnClick()
	if(data:GetIsRead() == MailReadType.No) then
		MailMgr:MailOperate({data:GetID()}, MailOperateType.Read)
	else
		if(cb) then
			cb(data:GetID())
		end
	end
end

---------------------------------------迭代遗留------------------------------------
-- function SetNum(rewards)
-- 	if(rewards and #rewards > 0) then
-- 		local numStr = StringUtil:SetColor(#rewards, "blue")
-- 		CSAPI.SetText(txtNum, string.format(StringConstant.mail_7, numStr))
-- 	else
-- 		CSAPI.SetText(txtNum, "")
-- 	end
-- end
-- function SetReward(rewards)
-- 	local _had = false
-- 	if(data:GetRewards() and #data:GetRewards() > 0) then
-- 		_had = true
-- 	end
-- 	CSAPI.SetGOActive(had, _had)
-- 	if(had) then
-- 		if(data:GetIsGet() == MailGetType.Yes) then
-- 			CSAPI.LoadImg(had, "UIs/Mail/triangle_grey.png", true, nil, true)
-- 		else
-- 			CSAPI.LoadImg(had, "UIs/Mail/triangle_yellow.png", true, nil, true)
-- 		end
-- 	end
-- end
function OnDestroy()	
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	clickNode = nil;
	nolImg = nil;
	selImg = nil;
	txtTime1 = nil;
	txtTime2 = nil;
	txtName = nil;
	open1 = nil;
	close1 = nil;
	open2 = nil;
	close2 = nil;
	newImg = nil;
	view = nil;
end
----#End#----
