local fade = nil
local move = nil
function Awake()
	fade = ComUtil.GetCom(action,"ActionFade")
	move = ComUtil.GetCom(action,"ActionMoveByCurve")
end
--SignInfDayInfo
local isNew = false
function Refresh(_data, _isNew)
	data = _data
	if data then
		index = data:GetIndex() or 1 --天
		isDone = data:CheckIsDone() --已签
		isCurDay = data:GetIsCurDay() 
		isSpecial = data:GetSpecial() ~= nil
		isNew = _isNew --是否是最新未签到天数
		
		local rewards = data:GetRewards()
		reward = rewards[1]  --只取一个数据
		
		SetIcon()
        SetDay()
        SetImages()
		SetSpecial()
	end
end

--reward 1：id 2：num 3：type
function SetIcon()		
	local _data = {type = reward[3], num = reward[2], id = reward[1]}	
	if(not item) then
		local go = ResUtil:CreateUIGO("Grid/GridItem", itemParent.transform)
		item = ComUtil.GetLuaTable(go)
	end
	local itemData = GridUtil.RandRewardConvertToGridObjectData(_data)
	item.Refresh(itemData)
	item.SetClickCB(GridClickFunc.OpenInfoShort)
	item.SetCount(0)
	if _data.type ~= RandRewardType.CARD then
		CSAPI.SetGOActive(item.bg, false)
	end
	-- num
	CSAPI.SetText(txtCount, "x" .. _data.num)

	--name
	CSAPI.SetText(txtName,itemData:GetName() or "")
	local color = (not isDone and isNew) and {255, 255, 255, 255} or {15, 15, 25, 255}
	CSAPI.SetTextColor(txtName, color[1], color[2], color[3], color[4])
end

function SetDay()
	local _index = index < 10 and "0" .. index or index
    CSAPI.SetText(txtDay, _index .. "")

    local color = (isDone) and {107, 107, 111, 255} or {255, 255, 255, 255}
    CSAPI.SetTextColor(txtDay, color[1], color[2], color[3], color[4])
    CSAPI.SetTextColor(txt_1, color[1], color[2], color[3], color[4])
    CSAPI.SetTextColor(txt_2, color[1], color[2], color[3], color[4])
end

function SetImages()
    -- 当天没签到的选中
    CSAPI.SetGOActive(cur, not isDone and isNew)

    -- done
    CSAPI.SetGOActive(get, isDone)
end

function SetSpecial()
	if index < 7 and isSpecial then
		CSAPI.LoadImg(nol,"UIs/SignInContinue/img_02_01.png",true,nil,true)
		CSAPI.LoadImg(cur,"UIs/SignInContinue/img_02_02.png",true,nil,true)
	end
end

function SetPos(pos)
	CSAPI.SetAnchor(gameObject,pos.x,pos.y)
end

function ShowAnim()
	local delay = index < 7 and math.floor(index / 4) * 100 or 0
	fade:Play(0,1,200,delay)
	move.delay = delay
	move:Play()
end

function OnDestroy()	
	if item then
		CSAPI.SetGOActive(item.bg, true)
	end
	ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()	
	gameObject = nil;
	transform = nil;
	this = nil;
	bg = nil;
	node = nil;
	itemParent = nil;
	icon = nil;
	doneImg = nil;
	num1 = nil;
	num2 = nil;
	view = nil;
end
----#End#----
