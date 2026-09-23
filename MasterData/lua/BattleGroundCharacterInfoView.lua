--战棋界面角色信息
local monsterType = nil;
function Awake()
	-- txtName = ComUtil.GetCom(name,"Text");
	txtLv = ComUtil.GetCom(txt_lv, "Text");
	hpImg = ComUtil.GetCom(hp, "Image")
end

function OnEnable()
	SetMonsterInfo(nil);	
	SetSelectState(false);
	CSAPI.SetGOActive(nInterValObj, false);
	CSAPI.SetGOActive(monsterTypeObj, false);
    SetSentryState();
	hpImg.fillAmount = 1
end

function SetCfg(targetCfg)
	cfg = targetCfg;
	-- txtName.text = cfg.name;
end

function GetCfg()
	return cfg;
end


function UpdateBuff(character)
	local toxicideCount = character.GetToxicideBuffCount();
	if(toxicideCount and toxicideCount > 0) then
		CSAPI.SetText(textToxicide, toxicideCount .. "");
	else
		CSAPI.SetText(textToxicide, "");
	end
	
	local smogCount = character.GetSmogBuffCount();
	if(smogCount and smogCount > 0) then
		CSAPI.SetText(textSmog, smogCount .. "");
	else
		CSAPI.SetText(textSmog, "");
	end
end

function AddClickCallBack(callBack)
	clickCallBack = callBack;
end

function SetFightState(isFighting)
	--CSAPI.SetGOActive(fighting,isFighting);
end

--percent：当前血量百分比
function SetMonsterHp(percent, isShow)
	percent = percent or 0;
	isShow = isShow == true and true or false;
	hpImg.fillAmount = 1 - percent;
	if monsterType ~= nil then
		CSAPI.SetGOActive(hpBarObj, isShow);
	end
end

function SetTeamNO(teamNO)
	local isFirst = teamNO == 1 and true or false
	CSAPI.SetGOActive(team01, isFirst)
	CSAPI.SetGOActive(team02, not isFirst)
end

--设置怪物信息
function SetMonsterInfo(_monsterType, nIntervaloff, nInterval, showLv)
	-- CSAPI.SetGOActive(levelBg,monsterType ~= nil);
	monsterType = _monsterType;
	isEnemy = monsterType ~= nil and true or nil
	CSAPI.SetGOActive(enemySel, isEnemy)
	CSAPI.SetGOActive(playerSel, not isEnemy)
	if(monsterType == nil) then
		CSAPI.SetGOActive(hpBarObj, false);
		CSAPI.SetGOActive(lvObj, false);
		return;
	else
		CSAPI.SetGOActive(hpBarObj, true);
		--lv
		if showLv and showLv > 0 then
			txtLv.text = showLv .. "";
			CSAPI.SetGOActive(lvObj, true);
		else
			CSAPI.SetGOActive(lvObj, false);
		end
	
		--回合
		if nInterval ~= nil and nInterval > 0 then
			CSAPI.SetGOActive(nInterValObj, true)
			local txt = tostring(nInterval -(BattleMgr:GetStepNum() + nIntervaloff) % nInterval);
			CSAPI.SetText(nInterValText1, txt)			
		else
			CSAPI.SetGOActive(nInterValObj, false)
		end
		-- CSAPI.SetGOActive(lvObj,true);
	end
	CSAPI.SetGOActive(monsterTypeObj, monsterType ~= nil);
	-- -- CSAPI.SetGOActive(goType1,monsterType == 1);
	CSAPI.SetGOActive(goType2, monsterType == 2);
	CSAPI.SetGOActive(goType3, monsterType == 3);
	-- txtLv.text = tostring(monsterLv);
	-- if monsterType==3 then
	--     --boss血条和小怪血条不同
	--     CSAPI.LoadImg(hphpBg,"UIs/Battle/white.png",true,nil,true);
	--     CSAPI.LoadImg(hphp,"UIs/Battle/black_blood.png",true,nil,true);
	-- else
	--     CSAPI.LoadImg(hphpBg,"UIs/Battle/back.png",true,nil,true);
	--     CSAPI.LoadImg(hphp,"UIs/Battle/red.png",true,nil,true);
	-- end
	-- if monsterType==1 or monsterType==3 then
	--     txtLv.text = "LV." .. monsterLv or "???";
	-- else
	--     txtLv.text = "LV.???";
	-- end
end

function SetSelectState(isSel)
	CSAPI.SetGOActive(selected, isSel);	
end

--创建角色飘字
function CreateFloatFont(data)
	--LogError(data);	
	local floatTrans = nil;
	if(IsNil(floatNode)) then		
		return;
	end
	floatTrans = floatNode.transform;
	local go = ResUtil:CreateUIGO("Common/FloatFontItem", floatTrans);
	if(not go) then
		LogError("create Common/FloatFontItem fail!");
		return;
	end
	local lua = ComUtil.GetLuaTable(go);
	lua.Set(data);
end

function OnClickEnter()
	if clickCallBack then
		clickCallBack();
	end
end

function Remove()
	CSAPI.RemoveGO(gameObject);
end

function SetShowState(isShow)
	CSAPI.SetGOActive(node, isShow);
end

function SetState(moveState)
	CSAPI.SetGOActive(nInterValBg2, moveState == 1)
	CSAPI.SetGOActive(selected, moveState == 1)
end

function OnRecycle()
	clickCallBack = nil;
	cfg = nil;
end 

function SetSentryState(stateNum)
    CSAPI.SetGOActive(sentryNode,stateNum and true or false);
    if(stateNum)then
        CSAPI.SetGOActive(sentry1,stateNum == 1);
        CSAPI.SetGOActive(sentry2,stateNum == 2);

        CSAPI.SetGOActive(nInterValObj, false);
    end
end