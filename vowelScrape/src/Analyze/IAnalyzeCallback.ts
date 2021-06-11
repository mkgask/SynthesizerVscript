import { AnalyzedData } from './AnalyzedData';



interface IAnalyzeCallback {
    (document : Document, analyzed_data : AnalyzedData) : AnalyzedData
} ;



export { IAnalyzeCallback };