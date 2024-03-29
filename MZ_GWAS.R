#MZ twins GWAS: Add paths for filenames
plinkfile=
phenfile=
covfile=
malelist=

#Add study name (e.g. TEDS)
#Note the GWAS should be performed separately for different sets of the study such as TEDS_Adults and TEDS_Children
study=

#Model 1: Primary analysis
#Residualised (PCs/covariates) rank transformed phenotypic difference ~ Genotype
#Add list of phenotypes

for i in height bmi edu sbp whr
do
j=`printf ${i}_t`


plink \
--bfile ${plinkfile} \
--linear \
--allow-no-sex \
--pheno ${phenfile} \
--pheno-name ${j} \
--out ./output/${study}_M1_${j}

done


#Model 2: As Model 1 but including the Within-pair mean as a covariate 

for i in height bmi edu sbp whr
do
j=`printf ${i}_t`
k=`printf ${i}M`

plink \
--bfile ${plinkfile} \
--linear \
--allow-no-sex \
--pheno ${phenfile} \
--pheno-name ${j} \
--covar ${covfile} \
--covar-name ${k} \
--out ./output/${study}_M2_${i}

done

#Model 3: As Model 1 but no PC adjustment

for i in height bmi edu sbp whr
do
j=`printf ${i}_nopc`
plink \
--bfile ${plinkfile} \
--linear \
--allow-no-sex \
--pheno ${phenfile} \
--pheno-name ${j} \
--out ./output/${study}_M3_${i}

done



#Model 4: Model 1 stratified by sex

for i in height bmi edu sbp whr
do
j=`printf ${i}_nx`

plink \
--bfile ${plinkfile} \
--linear \
--allow-no-sex \
--pheno ${phenfile} \
--pheno-name ${j} \
--keep ${malelist} \
--out ./output/${study}_M4_Male_${i}

done

for i in height bmi edu sbp whr
do
j=`printf ${i}_nx`

plink \
--bfile ${plinkfile} \
--linear \
--allow-no-sex \
--pheno ${phenfile} \
--pheno-name ${j} \
--remove ${malelist} \
--out ./output/${study}_M4_Female_${i}

done


