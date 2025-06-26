-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/survey/surveymaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSurveyConfig = (BeanManager.GetTableByName)("mail.csurveyconfig")
local CSurveyQuestionsTable = (BeanManager.GetTableByName)("mail.csurveyquestions")
local ItemTypeEnum = (LuaNetManager.GetBeanDef)("protocol.item.beans.item")
local TableFrame = require("framework.ui.frame.table.tableframe")
local Item = require("logic.manager.experimental.types.item")
local SurveyMainDialog = class("SurveyMainDialog", Dialog)
SurveyMainDialog.AssetBundleName = "ui/layouts.survey"
SurveyMainDialog.AssetName = "SurveyMain"
local split = function(str, reps)
  -- function num : 0_0 , upvalues : _ENV
  local resultStrList = {}
  ;
  (string.gsub)(str, "[^" .. reps .. "]+", function(w)
    -- function num : 0_0_0 , upvalues : _ENV, resultStrList
    (table.insert)(resultStrList, w)
  end
)
  return resultStrList
end

SurveyMainDialog.Ctor = function(self, ...)
  -- function num : 0_1 , upvalues : SurveyMainDialog
  ((SurveyMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._mail = nil
  self._itemsData = {}
  self._pagesData = {}
  self._currentPageIndex = 0
  self._currentPageQuestions = {}
  self._answerData = {}
  self._totleDelta = 0
end

SurveyMainDialog.OnCreate = function(self)
  -- function num : 0_2 , upvalues : TableFrame
  self._closeBtn = self:GetChild("CloseBtn")
  self._startPage = self:GetChild("Frame/SurveyStartPage")
  self._startPage_title = self:GetChild("Frame/SurveyStartPage/TitleBack/Title")
  self._startPage_headNote = self:GetChild("Frame/SurveyStartPage/HeadNote")
  self._startPage_count = self:GetChild("Frame/SurveyStartPage/Count")
  self._startPage_itemPanel = self:GetChild("Frame/SurveyStartPage/AwardFrame")
  self._startPage_startBtn = self:GetChild("Frame/SurveyStartPage/StartBtn")
  self._startPage_itemFrame = (TableFrame.Create)(self._startPage_itemPanel, self, false, false)
  self._surveyPage = self:GetChild("Frame/SurveyPage")
  self._surveyPage_title = self:GetChild("Frame/SurveyPage/TitleBack/Title")
  self._surveyPage_totalCount = self:GetChild("Frame/SurveyPage/TotalCount")
  self._surveyPage_finishCount = self:GetChild("Frame/SurveyPage/FinishCount")
  self._surveyPage_questionPanel = self:GetChild("Frame/SurveyPage/QuestionFrame")
  self._surveyPage_progressBar = self:GetChild("Frame/SurveyPage/Progress/ProgressBar")
  self._surveyPage_progressBarImage = ((self._surveyPage_progressBar):GetUIObject()):GetComponent("Image")
  self._surveyPage_pageNextBtn = self:GetChild("Frame/SurveyPage/PageNext")
  self._surveyPage_pageNextBtnTxt = self:GetChild("Frame/SurveyPage/PageNext/_Text")
  self._surveyPage_pageNextSubmitBtn = self:GetChild("Frame/SurveyPage/SubmitBtn")
  self._surveyPage_pageBeforeBtn = self:GetChild("Frame/SurveyPage/PageBefore")
  self._surveyPage_questionFrame = (TableFrame.Create)(self._surveyPage_questionPanel, self, true, true, true)
  ;
  (self._startPage_startBtn):Subscribe_PointerClickEvent(self.OnStartBtn, self)
  ;
  (self._surveyPage_pageNextBtn):Subscribe_PointerClickEvent(self.OnNext, self)
  ;
  (self._surveyPage_pageBeforeBtn):Subscribe_PointerClickEvent(self.OnBefore, self)
  ;
  (self._surveyPage_pageNextSubmitBtn):Subscribe_PointerClickEvent(self.OnSubmit, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

SurveyMainDialog.OnDestroy = function(self)
  -- function num : 0_3
  (self._startPage_itemFrame):Destroy()
  ;
  (self._surveyPage_questionFrame):Destroy()
end

SurveyMainDialog.Init = function(self, mail)
  -- function num : 0_4 , upvalues : CSurveyConfig, _ENV, split
  self._mail = mail
  ;
  (self._surveyPage):SetActive(false)
  local recorder = CSurveyConfig:GetRecorder(mail.questId)
  ;
  (self._startPage_title):SetText(recorder.name)
  ;
  (self._startPage_headNote):SetText(recorder.headnote)
  self._pagesData = {}
  for i,value in ipairs(recorder.pages) do
    local temp = {}
    for v in (string.gmatch)(value, "%d*") do
      v = tonumber(v)
      ;
      (table.insert)(temp, v)
    end
    -- DECOMPILER ERROR at PC43: Confused about usage of register: R9 in 'UnsetPending'

    ;
    (self._pagesData)[i] = {}
    -- DECOMPILER ERROR at PC46: Confused about usage of register: R9 in 'UnsetPending'

    ;
    ((self._pagesData)[i]).questions = temp
  end
  for i,value in ipairs(recorder.pageRequires) do
    local temp = {}
    local requiresArray = split(value, ";")
    for j,requiresArrayValue in pairs(requiresArray) do
      local idAndAnswer = split(requiresArrayValue, "@")
      local questId = idAndAnswer[1]
      local answers = idAndAnswer[2]
      temp[j] = {}
      -- DECOMPILER ERROR at PC74: Confused about usage of register: R18 in 'UnsetPending'

      ;
      (temp[j]).questId = tonumber(questId)
      -- DECOMPILER ERROR at PC82: Confused about usage of register: R18 in 'UnsetPending'

      if answers then
        (temp[j]).answers = split(answers, ",")
        for k,answer in pairs((temp[j]).answers) do
          answer = tonumber(answer)
        end
      end
    end
    -- DECOMPILER ERROR at PC98: Confused about usage of register: R10 in 'UnsetPending'

    ;
    ((self._pagesData)[i]).requires = temp
  end
  local count = self:GetTotleCount()
  ;
  (self._startPage_count):SetText(count)
  self._itemsData = mail.attachmentList
  ;
  (self._startPage_itemFrame):ReloadAllCell()
  ;
  (self._startPage):SetActive(true)
end

SurveyMainDialog.RefreshQuistionPanel = function(self, index, isNext)
  -- function num : 0_5 , upvalues : CSurveyConfig, _ENV, CSurveyQuestionsTable
  self._currentPageIndex = index
  if not self:IsPageCondition(((self._pagesData)[index]).requires) then
    if isNext then
      self:RefreshQuistionPanel(index + 1, true)
    else
      self:RefreshQuistionPanel(index - 1, false)
    end
    return 
  end
  if self._currentPageIndex == #self._pagesData then
    (self._surveyPage_pageNextSubmitBtn):SetActive(true)
    ;
    (self._surveyPage_pageNextBtn):SetActive(false)
    ;
    (self._surveyPage_pageBeforeBtn):SetActive(false)
  else
    ;
    (self._surveyPage_pageNextSubmitBtn):SetActive(false)
  end
  if self._currentPageIndex == 1 then
    (self._surveyPage_pageBeforeBtn):SetInteractable(false)
  else
    ;
    (self._surveyPage_pageBeforeBtn):SetInteractable(true)
  end
  local recorder = CSurveyConfig:GetRecorder((self._mail).questId)
  ;
  (self._surveyPage_title):SetText(recorder.name)
  local totleCount = self:GetTotleCount()
  local finishiCount = (table.nums)(self._answerData)
  ;
  (self._surveyPage_totalCount):SetText(totleCount)
  ;
  (self._surveyPage_finishCount):SetText(finishiCount)
  -- DECOMPILER ERROR at PC79: Confused about usage of register: R6 in 'UnsetPending'

  ;
  (self._surveyPage_progressBarImage).fillAmount = finishiCount / totleCount
  self._currentPageQuestions = {}
  for i,questId in pairs(((self._pagesData)[index]).questions) do
    local temp = {}
    recorder = CSurveyQuestionsTable:GetRecorder(questId)
    temp.id = recorder.id
    temp.questionType = recorder.questionType
    temp.questionTitle = recorder.questionTitle
    temp.selection = recorder.selection
    temp.multiCountMin = recorder.multiCountMin
    temp.multiCountMax = recorder.multiCountMax
    temp.confirmAnswer = recorder.confirmAnswer
    ;
    (table.insert)(self._currentPageQuestions, temp)
  end
  ;
  (self._surveyPage_questionFrame):ReloadAllCell()
  ;
  (self._surveyPage_questionFrame):MoveToTop()
  self:SetNextBtnState()
end

SurveyMainDialog.RefreshProgress = function(self)
  -- function num : 0_6 , upvalues : _ENV
  local totleCount = self:GetTotleCount()
  local finishiCount = (table.nums)(self._answerData)
  ;
  (self._surveyPage_totalCount):SetText(totleCount)
  ;
  (self._surveyPage_finishCount):SetText(finishiCount)
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R3 in 'UnsetPending'

  ;
  (self._surveyPage_progressBarImage).fillAmount = finishiCount / totleCount
end

SurveyMainDialog.GetTotleCount = function(self)
  -- function num : 0_7 , upvalues : _ENV
  local count = 0
  for i,value in ipairs(self._pagesData) do
    if tonumber(((value.requires)[1]).questId) == 0 then
      count = count + #value.questions
    else
      if self:IsPageCondition(value.requires) then
        count = count + #value.questions
      end
    end
  end
  return count
end

SurveyMainDialog.IsPageCondition = function(self, requires)
  -- function num : 0_8 , upvalues : _ENV
  if tonumber((requires[1]).questId) == 0 then
    return true
  end
  local condition = false
  for j,requireValue in ipairs(requires) do
    local answerData = (self._answerData)[requireValue.questId]
    -- DECOMPILER ERROR at PC26: Unhandled construct in 'MakeBoolean' P1

    if answerData and #answerData == #requireValue.answers then
      for key,answerValue in pairs(answerData) do
        if answerValue ~= tonumber((requireValue.answers)[key]) then
          condition = false
          return condition
        else
          condition = true
        end
      end
    end
    do
      do
        do return false end
        -- DECOMPILER ERROR at PC42: LeaveBlock: unexpected jumping out DO_STMT

      end
    end
  end
  return condition
end

SurveyMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_9
  self:Destroy()
end

SurveyMainDialog.OnStartBtn = function(self)
  -- function num : 0_10
  (self._surveyPage):SetActive(true)
  ;
  (self._startPage):SetActive(false)
  self:RefreshQuistionPanel(1)
end

SurveyMainDialog.OnNext = function(self)
  -- function num : 0_11
  self:RefreshQuistionPanel(self._currentPageIndex + 1, true)
end

SurveyMainDialog.OnSubmit = function(self)
  -- function num : 0_12 , upvalues : _ENV, CSurveyQuestionsTable
  local ccommitquest = (LuaNetManager.CreateProtocol)("protocol.mail.ccommitquest")
  if ccommitquest then
    local answer = ""
    for key,answers in pairs(self._answerData) do
      answer = answer .. key .. "@"
      for i,value in ipairs(answers) do
        answer = answer .. value .. ","
      end
      answer = (string.sub)(answer, 1, -2)
      answer = answer .. ";"
    end
    ccommitquest.uniqueId = (self._mail).uniqueId
    ccommitquest.answer = answer
    local validate = 0
    for i,pageValue in pairs(self._pagesData) do
      for j,questionId in pairs(pageValue.questions) do
        local recorder = CSurveyQuestionsTable:GetRecorder(questionId)
        if recorder.questionType == 4 and ((self._answerData)[recorder.id])[1] and ((self._answerData)[recorder.id])[1] == recorder.confirmAnswer then
          validate = 1
        end
      end
    end
    ccommitquest.validate = validate
    ccommitquest:Send()
    self:Destroy()
  end
end

SurveyMainDialog.OnBefore = function(self)
  -- function num : 0_13
  if self._currentPageIndex > 1 then
    self:RefreshQuistionPanel(self._currentPageIndex - 1, false)
  end
end

SurveyMainDialog.SetNextBtnState = function(self)
  -- function num : 0_14 , upvalues : _ENV
  for key,value in pairs(self._currentPageQuestions) do
    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    -- DECOMPILER ERROR at PC22: Unhandled construct in 'MakeBoolean' P1

    if (self._answerData)[value.id] and value.questionType == 2 and #(self._answerData)[value.id] < value.multiCountMin then
      (self._surveyPage_pageNextBtn):SetInteractable(false)
      ;
      (self._surveyPage_pageNextSubmitBtn):SetInteractable(false)
      return 
    end
    if #(self._answerData)[value.id] < 1 then
      (self._surveyPage_pageNextBtn):SetInteractable(false)
      ;
      (self._surveyPage_pageNextSubmitBtn):SetInteractable(false)
      return 
    end
    ;
    (self._surveyPage_pageNextBtn):SetInteractable(false)
    ;
    (self._surveyPage_pageNextSubmitBtn):SetInteractable(false)
    do return  end
  end
  if self._currentPageIndex == #self._pagesData then
    (self._surveyPage_pageNextBtn):SetInteractable(false)
  else
    ;
    (self._surveyPage_pageNextBtn):SetInteractable(true)
  end
  ;
  (self._surveyPage_pageNextSubmitBtn):SetInteractable(true)
end

SurveyMainDialog.OnSingleOptionChecked = function(self, questionId, answer, isChecked)
  -- function num : 0_15
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R4 in 'UnsetPending'

  if isChecked then
    (self._answerData)[questionId] = {answer}
  else
    -- DECOMPILER ERROR at PC18: Confused about usage of register: R4 in 'UnsetPending'

    if (self._answerData)[questionId] and ((self._answerData)[questionId])[1] == answer then
      (self._answerData)[questionId] = nil
    end
  end
end

SurveyMainDialog.OnMultipleOptionChecked = function(self, questionId, answers)
  -- function num : 0_16
  -- DECOMPILER ERROR at PC4: Confused about usage of register: R3 in 'UnsetPending'

  if #answers > 0 then
    (self._answerData)[questionId] = answers
  else
    -- DECOMPILER ERROR at PC7: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._answerData)[questionId] = nil
  end
end

SurveyMainDialog.OnTxtInput = function(self, questionId, str)
  -- function num : 0_17
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R3 in 'UnsetPending'

  if str then
    (self._answerData)[questionId] = {str}
  else
    -- DECOMPILER ERROR at PC9: Confused about usage of register: R3 in 'UnsetPending'

    ;
    (self._answerData)[questionId] = nil
  end
end

SurveyMainDialog.IsOptionChecked = function(self, id, index)
  -- function num : 0_18 , upvalues : _ENV
  if (self._answerData)[id] then
    for key,value in pairs((self._answerData)[id]) do
      if index == value then
        return true
      end
    end
  end
  do
    return false
  end
end

SurveyMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_19
  if frame == self._startPage_itemFrame then
    return #self._itemsData
  end
  if frame == self._surveyPage_questionFrame then
    return #self._currentPageQuestions
  end
end

SurveyMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_20
  if frame == self._startPage_itemFrame then
    return "survey.surveyitemcell"
  end
  if frame == self._surveyPage_questionFrame then
    if ((self._currentPageQuestions)[index]).questionType == 3 then
      return "survey.describequestioncell"
    else
      return "survey.selectquestioncell"
    end
  end
end

SurveyMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_21 , upvalues : ItemTypeEnum, Item, _ENV
  local data = {}
  if frame == self._startPage_itemFrame then
    local info = (self._itemsData)[index]
    local item = nil
    if info.itemtype == ItemTypeEnum.BASEITEM then
      item = (Item.Create)(info.id)
    else
      if info.itemtype == ItemTypeEnum.EQUIP then
        item = (Equip.Create)(info.id)
      else
        if info.itemtype == ItemTypeEnum.SKILL then
          item = (Skill.Create)(info.id)
        end
      end
    end
    item:InitWithFull(info)
    data.item = item
  end
  do
    if frame == self._surveyPage_questionFrame then
      data = (self._currentPageQuestions)[index]
    end
    return data
  end
end

SurveyMainDialog.ShouldLengthChange = function(self)
  -- function num : 0_22
  return true
end

return SurveyMainDialog

