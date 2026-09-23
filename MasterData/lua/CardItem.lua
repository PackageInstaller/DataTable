--卡牌简单头像
function Awake()
    starBar = ComUtil.GetCom(star, "BarBase");
	Clean()
end

function Clean()
	LoadFrame()
	LoadIcon()
	SetLV()
	SetStar()
end


function Init(cardData)
	if(cardData) then
		LoadFrame(cardData:GetQuality())
		LoadIcon(cardData:GetIcon())
		SetLV(cardData:GetLv())
		SetStar(cardData:GetBreakLevel())
	else
		Clean()
	end
end

--设置大小
function SetScalse(scale)
	CSAPI.SetScale(gameObject, scale, scale, 1)
end

--框
function LoadFrame(lvQuality)
	lvQuality = lvQuality or 1;
	local frame="";
    if lvQuality==nil or lvQuality==1 then
        frame="gray_box";
    elseif lvQuality==2 then
        frame="green_box";
    elseif lvQuality==3 then
        frame="blue_box";
    elseif lvQuality==4 then
        frame="purple_box";
    elseif lvQuality==5 then
        frame="yellow_box";
	end
	ResUtil.IconGoods:Load(bg, frame);
	-- ResUtil.IconGoods:Load(bg, "frame_" .. lvQuality);
end

--icon
function LoadIcon(iconName)
	CSAPI.SetGOActive(icon, iconName ~= nil);
	if(iconName) then
		ResUtil.IconGoods:Load(icon, iconName .. "");
	end
end

--level
function SetLV(lv)
	local lvStr = LanguageMgr:GetByID(1033) or "LV."
	local str = lv and lv > 1 and lvStr.. lv or ""
	CSAPI.SetText(level, str)
end

--设置星级
function SetStar(lvStar)	
	CSAPI.SetGOActive(star, lvStar and lvStar > 0);
	if(lvStar and lvStar > 0) then
		starBar:SetProgress(lvStar, lvStar);
	end
end 