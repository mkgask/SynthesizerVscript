import '../String.extensions';

import { IAnalyzer } from './IAnalyzer';
import { AnalyzedData } from './AnalyzedData';

import jsdom from 'jsdom';
import { access, readFile, writeFile } from 'fs/promises';
import { constants } from 'fs';
import { exception } from 'console';



class Analyer implements IAnalyzer
{
    // TODO
}



export { Analyer };