function [ Summary ] = DCEtoVessels( VesselStruct, DCEKTrans, DCEKep)
%Takes an aligned pair of DCE parameter images and Vessels and performs a
%comparison of the functional information with the structure.
ActiveThick = [];
PassiveThick = [];
ActiveTort = [];
PassiveTort = [];
ActiveCLR = [];
PassiveCLR = [];
ActiveLength = [];
PassiveLength = [];


EpActiveThick = [];
EpPassiveThick = [];
EpActiveTort = [];
EpPassiveTort = [];
EpActiveCLR = [];
EpPassiveCLR = [];
EpActiveLength = [];
EpPassiveLength = [];

nActive = 0;
nPassive = 0;

EpnActive = 0;
EpnPassive = 0;

for iV = 1:numel(VesselStruct)
    
   Vessel = VesselStruct{iV};
   
   
   
   for iB = 1:numel(Vessel.Branching.Branches);
      
       Branch = Vessel.Branching.Branches{iB};
       BranchInds = sub2ind(size(DCEKTrans.img),Branch.Points(:,2),Branch.Points(:,1),Branch.Points(:,3));
       Branch.BranchKTrans = DCEKTrans.img(BranchInds);
       Branch.BranchKep = DCEKep.img(BranchInds);
       
       if sum(Branch.BranchKTrans) > 0
           if (isfield(Branch,'Thickness'))
                ActiveThick = [ActiveThick Branch.Thickness];
           end
           ActiveTort = [ActiveTort Branch.Tortuosity];
           ActiveCLR = [ActiveCLR Branch.ChordLengthRatio];
           ActiveLength = [ActiveLength Branch.VesselLength];
           nActive = nActive + 1;
           
       else
           if (isfield(Branch,'Thickness'))
                PassiveThick = [PassiveThick Branch.Thickness];
           end
           PassiveTort = [PassiveTort Branch.Tortuosity];
           PassiveCLR = [PassiveCLR Branch.ChordLengthRatio];
           PassiveLength = [PassiveLength Branch.VesselLength];
           nPassive = nPassive + 1;
       end
       
      if sum(Branch.BranchKep) > 0
           if (isfield(Branch,'Thickness'))
                EpActiveThick = [EpActiveThick Branch.Thickness];
           end
           EpActiveTort = [EpActiveTort Branch.Tortuosity];
           EpActiveCLR = [EpActiveCLR Branch.ChordLengthRatio];
           EpActiveLength = [EpActiveLength Branch.VesselLength];
           EpnActive = EpnActive + 1;
           
       else
           if (isfield(Branch,'Thickness'))
                EpPassiveThick = [EpPassiveThick Branch.Thickness];
           end
           EpPassiveTort = [EpPassiveTort Branch.Tortuosity];
           EpPassiveCLR = [EpPassiveCLR Branch.ChordLengthRatio];
           EpPassiveLength = [EpPassiveLength Branch.VesselLength];
           EpnPassive = EpnPassive + 1;
       end
       
       Vessel.Branching.Branches{iB} = Branch;
   end
   
   VesselStruct{iV} = Vessel;
   
end

Summary.ActiveTort = ActiveTort;
Summary.PassiveTort = PassiveTort;

Summary.ActiveThick = ActiveThick;
Summary.PassiveThick = PassiveThick;

Summary.ActiveCLR = ActiveCLR;
Summary.PassiveCLR = PassiveCLR;

Summary.ActiveLength = ActiveLength;
Summary.PassiveLength = PassiveLength;

Summary.nActive = nActive;
Summary.nPassive = nPassive;

Summary.EpActiveTort = EpActiveTort;
Summary.EpPassiveTort = EpPassiveTort;

Summary.EpActiveThick = EpActiveThick;
Summary.EpPassiveThick = EpPassiveThick;

Summary.EpActiveCLR = EpActiveCLR;
Summary.EpPassiveCLR = EpPassiveCLR;

Summary.EpActiveLength = EpActiveLength;
Summary.EpPassiveLength = EpPassiveLength;

Summary.EpnActive = EpnActive;
Summary.EpnPassive = EpnPassive;


end

